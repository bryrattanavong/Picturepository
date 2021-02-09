module Queries
    class Purchase < Queries::BaseQuery
      argument :id, ID, required: true
      type Types::PurchaseType, null: false
  
      def resolve(id:)
        user = context[:current_user]
        return GraphQL::ExecutionError.new('ERROR: User not connected') if user.nil?
  
        purchase = ::Purchase.find_by(id: id)
        return GraphQL::ExecutionError.new('ERROR: Unavailable ID') if purchase.nil? || purchase.user != user
  
        purchase
      end
    end
  end
  