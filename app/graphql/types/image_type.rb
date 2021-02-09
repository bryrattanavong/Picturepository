module Types
    class ImageType < Types::BaseObject
      field :id, ID, null: false
      field :title, String, null: false
      field :description, String, null: false
      field :price, Float, null: false
      field :attached_image_url, String, null: false
      field :hash_tags,[HashTagType], null:true
      field :user, Types::UserType, null: false
    end
end
  