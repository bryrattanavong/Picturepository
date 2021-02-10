include Rails.application.routes.url_helpers
class Image < ApplicationRecord
  include IdentityCache

  belongs_to :user
  cache_belongs_to :user
  has_one_attached :attached_image

  validates :title, presence: true
  validates :price, presence: true
  validates :attached_image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']

  def attached_image_url
    Rails.cache.fetch([cache_key, __method__]) do
      Rails.application.routes.url_helpers
        .rails_blob_url(attached_image, only_path: true)
    end
  end
end