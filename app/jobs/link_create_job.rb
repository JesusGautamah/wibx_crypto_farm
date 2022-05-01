# frozen_string_literal: true

# Job to Create FarmLinks from Wibx
class LinkCreateJob
  include Sidekiq::Job
  sidekiq_options retry: false

  def perform(link, origin, product_title = nil)
    new_link = FarmLink.new(href: link, origin: origin, product_title: product_title)
    new_link.save
  rescue StandardError => e
    puts e.message
  else
    puts 'Farm Link created'
    FarmLink.find_by(href: link)
  end
end
