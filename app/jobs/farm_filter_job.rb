class FarmFilterJob
    include Sidekiq::Job
    sidekiq_options retry: false

    def perform()
        puts('Starting Tor Proxy')
        system 'sudo service tor start && sudo service privoxy start'
        sleep(10)
        puts('Done')

        puts('Starting Selenium')
        privoxy_proxy = "12
    end


end