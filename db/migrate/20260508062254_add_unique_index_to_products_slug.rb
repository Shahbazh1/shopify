class AddUniqueIndexToProductsSlug < ActiveRecord::Migration[8.1]
  def change
    add_index :products, [:store_id, :slug], unique: true
  end
end