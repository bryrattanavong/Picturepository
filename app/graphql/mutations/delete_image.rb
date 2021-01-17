
module Mutations
    class DeleteImage < BaseMutation
        argument :id, ID, required: true

        field :image, Types::ImageType, null: false
        field :errors, [String], null: false
  
      def resolve(id:)
        authorized_user
  
        image = Image.find(id)
  
        if image.present?
          if image.user == context[:current_user]
  
            image.destroy!
  
            raise GraphQL::ExecutionError, image.errors.full_messages.join(', ') unless image.errors.empty?
  
            image
          else
            raise GraphQL::ExecutionError, 'ERROR: Current User is not the creator of this Image'
          end
        else
          raise GraphQL::ExecutionError, "ERROR: Image with id #{id} does not exist"
        end
      end
    end
end