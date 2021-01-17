module Queries
 class Image < BaseQuery
   argument :id, ID, required: true
     
   type Types::ImageType, null: false
 
   def resolve(id:)
     image = Image.find_by(id: id)
     if image.present?
       image
     else 
       raise GraphQL::ExecutionError.new('This image does not exist')
     end
   end
 end
end