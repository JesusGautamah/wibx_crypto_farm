# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Lint/MissingCopEnableDirective

# Job to Create FarmLinks from Wibx
class LinkCreateJob
  include Sidekiq::Job
  sidekiq_options retry: false

  def perform(link, origin, product_title = nil)
    puts 'Creating FarmLink'
    puts link
    puts origin
    puts product_title
    new_link = FarmLink.new(href: link, origin: origin, product_title: product_title)
    new_link.save ? new_link : error = new_link.errors.full_messages.join(', ')
    puts "LinkCreateJob: #{error}" if error
  rescue StandardError => e
    puts e.message
  else
    FarmLink.find_by(href: link).nil? ? puts('Link not saved') : puts('Link saved')
    FarmLink.find_by(href: link)
  end
end
