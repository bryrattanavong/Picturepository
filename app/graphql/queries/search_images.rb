require 'search_object'
require 'search_object/plugin/graphql'

module Queries
    class SearchImages < BaseQuery
        include SearchObject.module(:graphql)

        scope { ::Image.where(private: false) }

        type Types::ImageType.connection_type, null: false

        class ImageFilter < ::Types::BaseInputObject
            argument :title_contains, String, required: false
            argument :description_contains, String, required: false
            argument :hashtag_contains, String, required: false
        end
        
        option :filter, type: ImageFilter, with: :apply_filter
        option :limit, type: types.Int, with: :apply_limit
        option :skip, type: types.Int, with: :apply_offset

        def apply_filter(scope, value)
            branches = normalize_filters(value)
            branches
        end

        def apply_limit(scope, value)
            scope.limit(value)
        end
          
        def apply_offset(scope, value)
            scope.offset(value)
        end

        def normalize_filters(value, branches = [])
            scope = ::Image.where(private: false)
            scope = scope.where('title LIKE ?', "%#{value[:title_contains]}%") if value[:title_contains]
            scope = scope.where('description LIKE ?', "%#{value[:description_contains]}%") if value[:description_contains]
            scope = scope.joins(:hash_tags).where(hash_tags:{name: value[:hashtag_contains] }) if value[:hashtag_contains]
            scope
        end
    end
end  