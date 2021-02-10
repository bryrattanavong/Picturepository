module Queries
    class Purchases < BaseQuery
      argument :page, Integer, required: true
      argument :limit, Integer, required: true
      type Types::PurchaseType.connection_type, null: false
  
      def resolve(page:, limit:)
       ::Purchase.order(id: :asc).page(page).per(limit)
      end
    end
  end