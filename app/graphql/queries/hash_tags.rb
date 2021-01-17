module Queries
    class HashTags < BaseQuery
      
      type Types::HashTagType.connection_type, null: false
  
      def resolve
       HashTag.all
      end
    end
  end