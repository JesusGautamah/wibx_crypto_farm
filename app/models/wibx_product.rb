# frozen_string_literal: true

# rubocop:disable Lint/MissingCopEnableDirective

# rubocop:disable Style/RedundantSelf

# Wibx Product Model
# I'm faking a foreign key to the FarmLink model, but it will be replaced by a real one
# Just enjoy the code
class WibxProduct < ApplicationRecord
  def facebook_uri
    FarmLink.find(self.facebook_link)
  end

  def whatsapp_uri
    FarmLink.find(self.whatsapp_link)
  end

  def instagram_uri
    FarmLink.find(self.instagram_link)
  end
end
