module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :balance, Float, null: false
    field :imageCount, Integer, null: false
    field :images, [Types::ImageType], null: false
    field :purchases, [Types::PurchaseType], null: false
  end
end