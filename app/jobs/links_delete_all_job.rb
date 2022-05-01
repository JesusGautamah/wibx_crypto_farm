# frozen_string_literal: true

# Job to Delete All FarmLinks
class LinksDeleteAllJob
  include Sidekiq::Job
  sidekiq_options retry: false

  def perform
    FarmLink.destroy_all
  rescue StandardError => e
    puts e.message
  else
    puts 'Farm Links deleted'
  end
end
