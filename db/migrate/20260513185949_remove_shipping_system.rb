class RemoveShippingSystem < ActiveRecord::Migration[8.1]
  def change
    remove_foreign_key :orders, :shipping_methods

    remove_column :orders, :shipping_method_id, :bigint

    drop_table :shipments

    drop_table :shipping_methods
  end
end
