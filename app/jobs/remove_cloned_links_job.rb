# frozen_string_literal: true

# Job to Remove Cloned Links
class RemoveClonedLinksJob
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    FarmLink.all.each do |link|
      list = FarmLink.where(href: link.href)
      puts list.length

      next unless list.length > 1

      list.each do |clone|
        clone.id != list[0].id ? clone.delete : nil
      end
    end
  end
end
