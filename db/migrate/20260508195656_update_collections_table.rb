class UpdateCollectionsTable < ActiveRecord::Migration[8.1]
  def change
    remove_column :collections, :name, :string

    add_column :collections, :title, :string

    add_column :collections, :selected_product_ids, :integer, array: true, default: []
  end
end