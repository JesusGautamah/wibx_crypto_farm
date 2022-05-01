# frozen_string_literal: true

# rubocop:disable Lint/MissingCopEnableDirective

# rubocop:disable Lint/RedundantCopDisableDirective

# rubocop:disable Lint/UselessAssignment

# rubocop:disable Metrics/LineLength

# Jobs to create Wibx Products
class WibxProductCreatorJob
  include Sidekiq::Job
  sidekiq_options retry: false

  def recognize_logged(driver)
    x = false
    driver.find_elements(:class, 'sessionHeader-title').size.positive? ? x = true : nil while x == false
  end

  def wibx_login(driver)
    puts('Login to Wibx')
    driver.navigate.to 'https://account.wibx.io/account/login'
    user = WibxAccount.first
    driver.find_element(:id, 'mat-input-4').send_keys(user.email)
    driver.find_element(:id, 'mat-input-5').send_keys(user.password)
    driver.find_element(:id, 'loginEnterBtn').click
    recognize_logged(driver)
    1
  rescue StandardError => e
    puts e.message
  end

  def start_selenium
    puts('Starting Selenium')
    proxy = {
      http: '127.0.0.1:8118', ssl: '127.0.0.1:8118', socks: '127.0.0.1:8118', socks_version: 5
    }
    caps = Selenium::WebDriver::Remote::Capabilities.firefox(proxy: proxy)
    puts 'Done'
    Selenium::WebDriver.for(:firefox, capabilities: caps)
  rescue StandardError => e
    puts e.message
  end

  def products_await(driver)
    x = false
    driver.find_elements(:class, 'product-imgContainer').size.positive? ? x = true : nil while x == false
    1
  end

  def start_tor_proxy
    system 'sudo service tor start && sudo service privoxy start'
    puts 'Starting Tor Proxy'
    10
  rescue StandardError => e
    puts e
  end

  def create_product(driver, product)
    puts('Creating Product')
    product.click
    sleep(10)
    sleep(create_value_per_social(driver))
    1
  end

  def products_refresher(driver)
    driver.navigate.to 'https://fidelidade.wiboo.io/?lang=en'
    sleep(products_await(driver))
    puts 'scroll down the page and load all products in'
    puts 'awaiting 30 seconds'
    sleep(30)
    1
  end

  def product_crawler(driver) # rubocop:disable Metrics/MethodLength
    sleep(products_refresher(driver))
    products = driver.find_elements(:class, 'product-imgContainer')
    products.each do |product|
      sleep(create_product(driver, product))
      driver.navigate.back
    end
    1
  end

  def create_value_per_social(driver) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    product = WibxProduct.new
    sleep(5)
    product.title = driver.find_element(:class, 'product-title').text
    social_list = [['facebook', 'gain', 'link'],
                   ['whatsapp', 'gain', 'link'],
                   ['telegram', 'gain', 'link']]
    social_list.each do |social|
      social[2] = FarmLink.find_by(origin: social[0], product_title: product.title).empty? ? nil : FarmLink.find_by(origin: social[0], product_title: product.title).id
      social[0] == 'telegram' ? text = driver.find_elements(:class, 'list-twitter')[1].text : text = driver.find_element(:class, "list-#{social[0]}").text
      social[0] = 'twitter'
      social[1] = text.gsub(/\R+/, '').gsub('Shares', '').gsub("Wonby#{social[0].capitalize}", '').gsub(' ', '')
      puts "Social: #{social} - Value: #{social[1]}"
      social == 'twitter' ? social = 'telegram' : nil
    end
    product.facebook_gain = social_list[0][1].to_flaot
    product.facebook_link = social_list[0][2]
    product.whatsapp_gain = social_list[1][1].to_float
    product.whatsapp_link = social_list[1][2]
    product.telegram_gain = social_list[2][1].to_float
    product.telegram_link = social_list[2][2]
    product.save
    1
  end

  def perform
    driver = start_selenium
    sleep(start_tor_proxy)
    sleep(wibx_login(driver))
    sleep(product_crawler(driver))
  end
end
