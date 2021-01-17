class AddPriceToImages < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :price, :float
  end
end
