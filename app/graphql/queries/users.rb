module Queries
    class Users < Queries::BaseQuery
      type Types::UserType.connection_type, null: false
  
      def resolve
        User.all
      end
    end
  end
  