class RemoveSelectedIdsFromDiscounts < ActiveRecord::Migration[8.1]
  def change
    remove_column :discounts, :selected_product_ids
    remove_column :discounts, :selected_collection_ids
  end
end