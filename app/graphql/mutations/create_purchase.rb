module Mutations
    class CreatePurchase < BaseMutation
      argument :id, ID, required: true

      type String

      def resolve(id:)
        authorized_user

        image = Image.find(id)
        return GraphQL::ExecutionError.new('ERROR: Requested Image is either private or does not exist') if image.nil? || image.private
        return GraphQL::ExecutionError.new('ERROR: User cannot purchase own Image') if context[:current_user] == image.user
        return GraphQL::ExecutionError.new('ERROR: User cannot afford this purchase') if context[:current_user].balance < image.price

        ActiveRecord::Base.transaction do
          purchase = ::Purchase.create!(
            title: image.title,
            description: image.description,
            user_id: context[:current_user].id,
            seller_id: image.user.id,
            cost: image.price
          )

          purchase.image.attach(image.image.attachment.blob)
          purchase.save

          user.update!(balance: user.balance - image.price)
          image.user.update!(balance: image.user.balance + image.price)
        end

        'Succesfully purchased image.'

      rescue ActiveRecord::RecordInvalid
        GraphQL::ExecutionError.new('ERROR: Invalid operation. Transaction was not successfully completed')
      end
    end
end