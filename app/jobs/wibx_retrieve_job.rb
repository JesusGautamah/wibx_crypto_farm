# frozen_string_literal: true

# rubocop:disable Lint/MissingCopEnableDirective

# rubocop:disable Metrics/ClassLength, Metrics/MethodLength

# rubocop:disable Metrics/AbcSize

# Job to Create FarmLinks from Wibx
class WibxRetrieveJob
  include Sidekiq::Job
  sidekiq_options retry: false

  def logged_in_detection(driver) # rubocop:disable
    x = false
    now = Time.now
    while now + 60.seconds > Time.now
      driver.find_elements(:xpath, "//div[@role='banner']").size.positive? ? x = true : x = false # rubocop:disable Style/ConditionalAssignment
      if x == true
        puts 'Logged in'
        break
      end
    end
    x
  end

  def wibx_list_page(driver)
    driver.navigate.to 'https://fidelidade.wiboo.io/?lang=en'
    puts 'waiting 40 seconds, roll page down to load more products'
    sleep(40)
  rescue StandardError => e
    puts e.message
  end

  def create_if_face_link_founded(driver, product_title = nil)
    sleep(8)
    if driver.find_elements(:xpath, "//a[@rel='noopener nofollow']").size.positive?
      href = driver.find_element(:xpath, "//a[@rel='noopener nofollow']").attribute('href')
      LinkCreateJob.perform_async(href, 'facebook', product_title)
    else
      puts 'something wrong, maybe blocked account or login failed'
    end
    1
  rescue StandardError => e
    puts e.message
  end

  def facebook_share(driver, share, text)
    puts 'Starting Facebook Share'
    share.click
    sleep(8)
    driver.switch_to.window(driver.window_handles[1])
    sleep(create_if_face_link_founded(driver, text))
    driver.close
    driver.switch_to.window(driver.window_handles[0])
    1
  rescue StandardError => e
    puts e.message
    puts 'Facebook share failed'
  end

  def create_if_whatsapp_link_founded(driver, product_title = nil)
    sleep(10)
    href_to_save = ''
    href_text = driver.find_elements(:class, '_9vd5')
    href_text.each do |href|
      if href.text.include?('https') && href.text.include?(product_title)
        puts href.text
        href_to_save = URI.extract(href.text).first
      end
    end
    puts href_to_save
    LinkCreateJob.perform_async(href_to_save, 'whatsapp', product_title)
    1
  rescue StandardError => e
    puts e.message
  end

  def whatsapp_share(driver, share, text)
    puts 'Starting Whatsapp Share'
    share.click
    sleep(15)
    driver.switch_to.window(driver.window_handles[1])
    sleep(create_if_whatsapp_link_founded(driver, text))
    driver.close
    driver.switch_to.window(driver.window_handles[0])
    1
  rescue StandardError => e
    puts e.message
    puts 'Whatsapp share failed'
  end

  def create_if_telegram_link_founded(driver, product_title = nil)
    href = URI.extract(driver.find_element(:class, 'tgme_page_desc_header').text).first
    LinkCreateJob.perform_async(href, 'telegram', product_title)
    1
  rescue StandardError => e
    puts e.message
  end

  def telegram_share(driver, share, text)
    puts 'Starting Telegram Share'
    share.click
    driver.switch_to.window(driver.window_handles[1])
    sleep(15)
    sleep(create_if_telegram_link_founded(driver, text))
    driver.close
    driver.switch_to.window(driver.window_handles[0])
    driver.find_element(:class, 'share-close').click
    1
  rescue StandardError => e
    puts e.message
  end

  def click_on_social(driver, share, text, shares, facebook)
    if share == shares[0] && !facebook.nil?
      sleep(facebook_share(driver, share, text))
    elsif share == shares[1]
      sleep(whatsapp_share(driver, share, text))
    elsif share == shares[2]
      puts 'Twitter is not available'
    elsif share == shares[3]
      sleep(telegram_share(driver, share, text))
    end
    1
  end

  def click_on_share(driver, btn, farm_when_done, facebook)
    btn.click
    sleep(10)
    shares = driver.find_elements(:class, 'share-linkSocial')
    text = driver.find_element(:class, 'mat-dialog-title').text
    shares.each do |share|
      sleep(click_on_social(driver, share, text, shares, facebook))
    end
    farm_when_done == true ? start_farming : puts('done')
  end

  def start_farming(facebook)
    puts('Starting Farm')
    with_facebook = WibxFarmJob.perform_async(5000, facebook, driver)
    without_facebook = WibxFarmJob.perform_async(5000, nil, driver)
    facebook == 'true' ? with_facebook : without_facebook
  rescue StandardError => e
    puts e.message
  end

  def share_fidelity(driver, facebook = nil, farm_when_done = nil)
    puts 'Starting Share'
    wibx_list_page(driver)
    buttons = driver.find_elements(:class, 'product-action')
    buttons.each do |btn|
      click_on_share(driver, btn, facebook, farm_when_done)
    end
    # driver.close
    5
  rescue StandardError => e
    puts e.message
  end

  def element_click(driver)
    face_user = FaceAccount.first
    driver.find_element(:id, 'email').send_keys face_user.email
    driver.find_element(:id, 'pass').send_keys face_user.password
    driver.find_element(:name, 'login').click
    logged_in_detection(driver)
    1
  rescue StandardError => e
    puts e
  end

  def login_facebook(driver, farm_when_done = nil)
    driver.navigate.to('https://www.facebook.com/')
    sleep(10)
    unless farm_when_done == true && logged_in_detection(driver) == true
      button_cookie = "//button[@title='Only allow essential cookies']"
      driver.find_elements(:xpath, button_cookie).size.positive? ? driver.find_element(:xpath, button_cookie).click : nil # rubocop:disable Layout/LineLength
      sleep(element_click(driver))
    end
  rescue StandardError => e
    puts e.message
  end

  def start_tor_proxy
    system 'easypx start'
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
    Selenium::WebDriver.for(:firefox, capabilities: caps)
  rescue StandardError => e
    puts e.message
  end

  def recognize_logged(driver)
    x = false
    while x == false
      begin
        driver.find_elements(:class, 'sessionHeader-title').size.positive? ? x = true : nil
      rescue StandardError => e
        puts e.message
      end
    end
    1
  end

  def wibx_login(driver)
    puts('Login to Wibx')
    driver.navigate.to 'https://account.wibx.io/account/login'
    user = WibxAccount.first
    driver.find_element(:id, 'mat-input-4').send_keys(user.email)
    driver.find_element(:id, 'mat-input-5').send_keys(user.password)
    driver.find_element(:id, 'loginEnterBtn').click
    sleep(recognize_logged(driver))
    1
  rescue StandardError => e
    puts e.message
  end

  def stop_tor_proxy(farm_when_done)
    return 5 if farm_when_done == 'true'

    puts('Stopping Tor Proxy')
    system 'easypx stop'
    puts('Done')
    driver.close
    5
  rescue StandardError => e
    puts e.message
  end

  def perform(facebook, farm_when_done = nil)
    start_tor_proxy
    sleep(10)
    driver = start_selenium
    facebook == 'true' ? login_facebook(driver, farm_when_done) : nil
    sleep(wibx_login(driver))
    sleep(share_fidelity(driver, facebook, farm_when_done))
    sleep(stop_tor_proxy(farm_when_done))
  rescue StandardError => e
    puts e.message
  end
end
