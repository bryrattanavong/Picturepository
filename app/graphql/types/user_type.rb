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

  def images
    Loaders::HasManyLoader.for(Image, :images).load(object)
  end

  def purchases
    Loaders::HasManyLoader.for(Purchase, :purchases).load(object)
  end
end