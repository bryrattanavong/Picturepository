class AddDiscountToPurchase < ActiveRecord::Migration[6.0]
  def change
    add_column :purchases, :discount, :float
  end
end
