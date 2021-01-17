module Mutations
    class UpdateImage < BaseMutation
      argument :id, ID, required: true
      argument :title, String, required: false
      argument :description, String, required: false
      argument :private, Boolean, required: false
      argument :image, Types::FileType, required: false

      type Types::ImageType

      def resolve(id:, title: nil, description: nil, private: nil, image: nil)
        authorized_user

        photo = Image.find_by(id: id)

        if photo.present?
          if photo.user == context[:current_user]

            photo.title = title if title.present?
            photo.description = description if description.present?
            photo.private = private if private.present?
            photo.image = image if image.present?
            photo.save

            raise GraphQL::ExecutionError, photo.errors.full_messages.join(', ') unless photo.errors.empty?

            photo
          else
            raise GraphQL::ExecutionError, 'ERROR: Not owner of image'
          end
        else
          raise GraphQL::ExecutionError, "ERROR: Image with id #{id} does not exist"
        end
      end
    end
end
