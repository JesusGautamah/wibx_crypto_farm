# frozen_string_literal: true

# Job to Update FarmLinks from Wibx
class LinkUpdateJob
  include Sidekiq::Job
  sidekiq_options retry: false

  def perform(link, product_title, fail = nil)
    fail == true ? link.update(fail: true) : link.update(product_title: product_title)
  rescue StandardError => e
    puts e.message
  else
    puts 'Link updated'
  end
end
