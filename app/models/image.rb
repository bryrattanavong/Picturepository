include Rails.application.routes.url_helpers
class Image < ApplicationRecord
  scope :public_images, -> { where(private: false) }

  validates :image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']
  validates :title, presence: true
  validates :price, presence: true

  belongs_to :user
  has_many :image_hash_tags
  has_many :hash_tags, through: :image_hash_tags
  has_one_attached :image

  def image_url
    Rails.application.routes.url_helpers
      .rails_blob_url(image, only_path: true)
  end
end