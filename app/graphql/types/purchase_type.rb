module Types
    class PurchaseType < Types::BaseObject
      field :id, ID, null: false
      field :title, String, null: false
      field :description, String, null: false
      field :cost, Float, null: false
      field :image_url, String, null: false
      field :user, Types::UserType, null: false
      field :seller, Types::UserType, null: false
    end
  
    def user
      RecordLoader.for(User).load(object.user_id)
    end
  
    def seller
      RecordLoader.for(User).load(object.seller_id)
    end
  end