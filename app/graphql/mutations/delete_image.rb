module Mutations
    class DeleteImage < BaseMutation
        argument :id, ID, required: true

        field :image, Types::ImageType, null: false
        field :errors, [String], null: false
  
      def resolve(id:)
        authorized_user
  
        image = Image.find_by(id: id)
  
        if image.present?
          if image.user == context[:current_user]
            image.destroy
            {
              image: image,
              errors: []
            }
          else
            raise GraphQL::ExecutionError, 'ERROR: User is not the owner of this Image'
          end
        else
          raise GraphQL::ExecutionError, "ERROR: Does not exist"
        end
      end
    end
end