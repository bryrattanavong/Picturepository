module Mutations
  class CreateImage < BaseMutation
    argument :title, String, required: true
    argument :description, String, required: true
    argument :price, Float, required: true
    argument :private, Boolean, required: true
    argument :image, Types::FileType, required: true
  
    type Types::ImageType

    def resolve(image:, description: nil, people: nil)
      authorized_user
      image = Image.create!(
        title: title,
        description: description,
        price: price,
        private: private,
        image: image,
        user_id: context[:current_user].id
      )
      raise GraphQL::ExecutionError, image.errors.full_messages.join(", ") unless image.errors.empty?
      if image.present?
        description.to_s.scan(/#\w+/).map{|tag| tag.gsub("#", "")}.each do |tag|
          hash_tag = HashTag.find_by(name: tag)
          if hash_tag.nil?
            hash_tag = HashTag.create(
              name: tag
            )
          end
          image_hashtag = ImageHashTag.create(
            image_id: image.id,
            hash_tag_id: hash_tag.id
          )
          raise GraphQL::ExecutionError, image_hashtag.errors.full_messages.join(", ") unless image_hashtag.errors.empty?   
        end  
      end
    image
    end
  end
end 