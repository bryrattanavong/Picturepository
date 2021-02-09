include Rails.application.routes.url_helpers
class Purchase < ApplicationRecord
    include IdentityCache
    validates :title, presence: true
    validates :cost, presence: true
  
    belongs_to :user
    belongs_to :seller, class_name: 'User', foreign_key: 'seller_id', required: false
  
    has_one_attached :attached_image
  
    def attached_image_url
      Rails.cache.fetch([cache_key, __method__]) do
        Rails.application.routes.url_helpers
          .rails_blob_url(attached_image, only_path: true)
      end
    end
  end
  
