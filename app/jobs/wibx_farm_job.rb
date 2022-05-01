# frozen_string_literal: true

# rubocop:disable Lint/MissingCopEnableDirective

# rubocop:disable Metrics/ClassLength, Metrics/MethodLength, Metrics/LineLength
# Job to Farm Wibx Utility Token
class WibxFarmJob
  include Sidekiq::Job
  sidekiq_options retry: false

  def logged_in_detection(driver) # rubocop:disable
    x = false
    driver.find_elements(:xpath, "//div[@role='banner']").size.positive? ? x = true : nil while x == false
  end

  def element_click(driver)
    face_user = FaceAccount.first
    driver.find_element(:id, 'email').send_keys face_user.email
    driver.find_element(:id, 'pass').send_keys face_user.password
    driver.find_element(:name, 'login').click
    logged_in_detection(driver)
    0.1
  rescue StandardError => e
    puts e
  end

  def login_facebook(driver)
    driver.navigate.to('https://www.facebook.com/')
    button_cookie = "//button[@title='Only allow essential cookies']"
    x = false
    while x == false
      driver.find_elements(:xpath, button_cookie).size.positive? ? x = true : x = false # rubocop:disable Style/ConditionalAssignment
    end
    driver.find_element(:xpath, button_cookie).click
    sleep(element_click(driver))
  rescue StandardError => e
    puts e.message
  end

  def start_tor_proxy
    system 'sudo service tor start && sudo service privoxy start'
    sleep(10)
    puts 'Started Tor Proxy'
  rescue StandardError => e
    puts e
  end

  def start_selenium
    puts('Starting Selenium')
    proxy = {
      http: '127.0.0.1:8118', ssl: '127.0.0.1:8118', socks: '127.0.0.1:8118', socks_version: 5
    }
    caps = Selenium::WebDriver::Remote::Capabilities.firefox(proxy: proxy)
    puts 'Done'
    Selenium::WebDriver.for(:firefox, capabilities: caps, options: Selenium::WebDriver::Firefox::Options.new(args: ['--disable-web-security']))
  rescue StandardError => e
    puts e.message
  end

  def catch_links(facebook, driver)
    facebook == 'true' ? login_facebook(driver) : nil
    facebook == 'true' ? FarmLink.all : FarmLink.where.not('href like ?', '%facebook%')
  rescue StandardError => e
    puts e
  end

  def retry_connection(facebook)
    puts 'Reset Tor Proxy & Start new Selenium driver'
    system 'sudo service tor restart && sudo service privoxy restart'
    system 'killall -9 firefox-esr'
    puts 'Done'
    sleep(10)
    driver = start_selenium
    catch_links(facebook, driver)
    driver
  rescue StandardError => e
    puts e.message
  end

  def try_links(links, driver) # rubocop:disable Metrics/AbcSize
    current_link = nil
    links.each do |link|
      current_link = link
      link.fail == (false || nil) ? driver.navigate.to(link.href) : next
    end
    puts "Link #{current_link.product_title} from #{current_link.origin} success"
  rescue StandardError => e
    puts "Link #{current_link.product_title} from #{current_link.origin} failed"
    puts e
    driver = links.where(origin: 'facebook').size.positive? ? retry_connection('true') : retry_connection('false')
    current_link.update(fail: true)
    [0.1, driver]
  else
    puts 'next'
    [0.1, driver]
  end

  def tor_new_identification
    puts 'Changing Tor Proxy'
    system 'sudo service tor restart && sudo service privoxy restart'
    sleep(5)
  rescue StandardError => e
    puts e
  end

  def stop_proxy
    puts('Stopping Tor Proxy')
    system 'sudo service tor stop && sudo service privoxy stop'
    sleep(20)
    puts('Done')
  end

  def start_farming(driver, links, number)
    n = 0
    number.to_i.times do
      n += 1
      percent = (n.to_f / number.to_i) * 100
      puts("#{percent.round(4)}%")
      sleep((farming = try_links(links, driver))[0])
      driver = farming[1]
      tor_new_identification
    end
    0.1
  rescue StandardError => e
    puts e.message
  end

  def perform(number, facebook = nil, driver = nil)
    start_tor_proxy
    driver.nil? ? driver = start_selenium : nil
    links = catch_links(facebook, driver)
    sleep(5)
    puts('Starting to farm')
    sleep(start_farming(driver, links, number))
    driver.close
  rescue StandardError => e
    puts e.message
  end
end
