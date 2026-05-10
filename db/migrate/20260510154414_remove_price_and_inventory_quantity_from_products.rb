class RemovePriceAndInventoryQuantityFromProducts < ActiveRecord::Migration[8.1]
   def change
    remove_column :products, :price, :decimal
    remove_column :products, :inventory_quantity, :integer
  end
end
