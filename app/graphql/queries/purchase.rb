module Queries
    class Purchase < Queries::BaseQuery
      argument :id, ID, required: true
      type Types::PurchaseType, null: false
  
      def resolve(id:)
        user = context[:current_user]
        return GraphQL::ExecutionError.new('ERROR: Not logged in or missing token') if user.nil?
  
        purchase = Purchase.find(id)
        return GraphQL::ExecutionError.new('ERROR: Purchase of given ID is nil') if purchase.nil? || purchase.user != user
  
        purchase
      end
    end
  end
  