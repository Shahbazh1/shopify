class RemoveSelectedProductIdsFromCollections < ActiveRecord::Migration[8.1]
  def change
  remove_column :collections, :selected_product_ids, :integer, array: true
end
end
