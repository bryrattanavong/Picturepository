class User < ApplicationRecord
    has_secure_password
  
    validates :name, presence: true
    validates :balance, presence: true
    validates :email, presence: true, uniqueness: true
  
    has_many :images, dependent: :destroy
    has_many :purchases, dependent: :destroy
  
    def image_count
      Rails.cache.fetch([cache_key, __method__]) do
        images.count
      end
    end
  end