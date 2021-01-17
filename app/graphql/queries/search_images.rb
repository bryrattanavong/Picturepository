module Queries
    class SearchImages < Queries::BaseQuery
      argument :search_input, String, required: true
      type Types::ImageType.connection_type, null: false
  
      def resolve(search_input:)
        images = ::Image.public_images
        results = []
        images.each do |i|
          results << i if i.search_string.downcase.include?(search_input.downcase)
        end
        results
      end
    end
  end