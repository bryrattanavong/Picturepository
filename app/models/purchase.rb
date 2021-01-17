include Rails.application.routes.url_helpers
class Purchase < ApplicationRecord
    validates :title, presence: true
    validates :cost, presence: true
  
    belongs_to :user
    belongs_to :seller, class_name: 'User', foreign_key: 'seller_id', required: false
  
    has_one_attached :image
  
    def image_url
      Rails.application.routes.url_helpers
        .rails_blob_url(image, only_path: true)
    end
  end
  
