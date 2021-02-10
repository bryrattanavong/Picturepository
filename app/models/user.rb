class User < ApplicationRecord
    has_secure_password
    include IdentityCache
  
    validates :name, presence: true
    validates :balance, presence: true
    validates :email, presence: true, uniqueness: true
  
    has_many :images, dependent: :destroy
    cache_has_many :images, embed: true
    has_many :purchases, dependent: :destroy
    cache_has_many :purchases, embed: true
  
    def image_count
      Rails.cache.fetch([cache_key, __method__]) do
        images.count
      end
    end
  end