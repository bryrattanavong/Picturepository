module Queries
    class User < Queries::BaseQuery
      argument :id, ID, required: true
      type Types::UserType, null: false
  
      def resolve(id:)
        user = User.find_by(id: id)
        if user.present?
          user
        else 
          raise GraphQL::ExecutionError.new('This user does not exist')
        end
      end
    end
  end
  