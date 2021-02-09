module Mutations
  class CreateImage < BaseMutation
    argument :title, String, required: true
    argument :description, String, required: true
    argument :price, Float, required: true
    argument :private, Boolean, required: true
    argument :image, Types::FileType, required: true
  
    type Types::ImageType

    def resolve(title:, price:, private:, image:, description: )
      authorized_user
      image = ::Image.create!(
        title: title,
        description: description,
        price: price,
        private: private,
        attached_image: image,
        user_id: context[:current_user].id
      )
      raise GraphQL::ExecutionError, image.errors.full_messages.join(", ") unless image.errors.empty?
    image
    end
  end
end 