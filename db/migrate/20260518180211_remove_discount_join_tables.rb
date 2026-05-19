class RemoveDiscountJoinTables < ActiveRecord::Migration[8.1]
  def change
    drop_table :collection_discounts
    drop_table :product_discounts
  end
end
