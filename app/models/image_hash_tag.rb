class ImageHashTag < ApplicationRecord
    belongs_to :image
    belongs_to :hash_tag
end
