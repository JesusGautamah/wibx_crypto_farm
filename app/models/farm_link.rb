class FarmLink < ApplicationRecord
    validates :href , presence: true, uniqueness: true
    enum :origin, [:facebook, :whatsapp, :telegram]
end
