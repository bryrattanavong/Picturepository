class HashTag < ApplicationRecord
    has_many :image_hash_tags
    has_many :images, through: :image_hash_tags
end
