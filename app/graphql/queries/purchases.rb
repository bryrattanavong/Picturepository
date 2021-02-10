module Queries
    class Purchases < BaseQuery
      type Types::PurchaseType.connection_type, null: false
  
      def resolve
       ::Purchase.all
      end
    end
  end