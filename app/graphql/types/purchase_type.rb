module Types
    class PurchaseType < Types::BaseObject
      field :id, ID, null: false
      field :title, String, null: false
      field :description, String, null: false
      field :cost, Float, null: false
      field :discount, Float, null: true
      field :attached_image_url, String, null: false
      field :user, Types::UserType, null: false
      field :seller, Types::UserType, null: false
    end
  end