module Queries
    class Users < Queries::BaseQuery
      argument :page, Integer, required: true
      argument :limit, Integer, required: true
      type Types::UserType.connection_type, null: false
  
      def resolve(page:, limit:)
        ::User.page(page).per(limit)
      end
    end
  end
  