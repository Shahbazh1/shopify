class AddProductFieldsToProducts < ActiveRecord::Migration[8.1]
  def change
    add_column :products, :status, :string, default: "draft"
    add_column :products, :category, :string
    add_column :products, :inventory_quantity, :integer, default: 0
    add_column :products, :published_online_store, :boolean, default: false
    add_column :products, :published_pos, :boolean, default: false
  end
end
