class AddSellerRefToPurchases < ActiveRecord::Migration[6.0]
  def change
    add_reference :purchases, :seller, index:true
  end
end
