module Mutations
    class CreatePurchase < BaseMutation
      argument :id, ID, required: true
      argument :discount, Float, required: false

      type Types::PurchaseType

      def resolve(id:, discount:nil)
        authorized_user

        image = ::Image.find_by(id: id)
        if image.nil? || image.private
          return GraphQL::ExecutionError.new('ERROR: Requested Image is either private or does not exist')
        end

        if context[:current_user] == image.user
          return GraphQL::ExecutionError.new('ERROR: User cannot purchase own Image')
        end
        
        if context[:current_user].balance < image.price
          return GraphQL::ExecutionError.new('ERROR: User cannot afford this purchase') 
        end

        ActiveRecord::Base.transaction do
          if discount.present?
            if discount < 0
              return GraphQL::ExecutionError.new('ERROR: discount cant be less than 0') 
            end
            
            if discount > 100
              return GraphQL::ExecutionError.new('ERROR: discount cant be greater than 100') 
            end
            calculatePrice = image.price - (image.price * (discount/100))
          else
            calculatePrice = image.price
          end
          context[:current_user].update!(balance: context[:current_user].balance - calculatePrice)
          image.user.update!(balance: image.user.balance + calculatePrice)

          purchase = ::Purchase.create!(
            title: image.title,
            description: image.description,
            user_id: context[:current_user].id,
            seller_id: image.user.id,
            cost: image.price,
            discount: discount
          )
          image.update!(user_id: context[:current_user].id)
          
          purchase.attached_image.attach(image.attached_image.attachment.blob)
          purchase.save

          purchase
        end


      rescue ActiveRecord::RecordInvalid
        GraphQL::ExecutionError.new('ERROR: Purchase incomplete')
      end
    end
end