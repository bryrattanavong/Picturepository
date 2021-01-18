require 'search_object'
require 'search_object/plugin/graphql'

module Queries
    class SearchImages < BaseQuery
        include SearchObject.module(:graphql)

        scope { Image.public_images }

        type Types::ImageType.connection_type, null: false

        class ImageFilter < ::Types::BaseInputObject
            argument :OR, [self], required: false
            argument :description_contains, String, required: false
            argument :hashtag_contains, String, required: false
        end
        
        option :filter, type: ImageFilter, with: :apply_filter

        def apply_filter(scope, value)
            branches = normalize_filters(value).reduce { |a, b| a.or(b) }
            scope.merge branches
        end
        
        def normalize_filters(value, branches = [])
            scope = Image.public_images
            scope = scope.where('description LIKE ?', "%#{value[:description_contains]}%") if value[:description_contains]
            scope = scope.joins(:hash_tags).where(hash_tags:{name: value[:hashtag_contains] }) if value[:hashtag_contains]
            branches << scope
            value[:OR].reduce(branches) { |s, v| normalize_filters(v, s) } if value[:OR].present?
            branches
        end
    end
end  