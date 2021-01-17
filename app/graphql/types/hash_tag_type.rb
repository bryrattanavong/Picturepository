module Types
  class HashTagType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :images, [ImageType], null: true
  end
end
