module Mutations
    class CreatePurchase < BaseMutation
      argument :id, ID, required: true

      type String

      def resolve(id:)
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
          purchase = ::Purchase.create!(
            title: image.title,
            description: image.description,
            user_id: context[:current_user].id,
            seller_id: image.user.id,
            cost: image.price
          )

          purchase.attached_image.attach(image.attached_image.attachment.blob)
          purchase.save

          context[:current_user].update!(balance: context[:current_user].balance - image.price)
          image.user.update!(balance: image.user.balance + image.price)
          image.update!(user_id: context[:current_user].id)
        end

        'Purchased complete.'

      rescue ActiveRecord::RecordInvalid
        GraphQL::ExecutionError.new('ERROR: Purchase incomplete')
      end
    end
end