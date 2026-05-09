class CleanupDiscountsTable < ActiveRecord::Migration[8.1]
  def change
    # 1. Remove unnecessary fields
    remove_column :discounts, :applies_to, :string
    remove_column :discounts, :collection_id, :bigint # Removing single ID
    remove_column :discounts, :product_id, :bigint    # Removing single ID
    remove_column :discounts, :order_discount, :boolean
    remove_column :discounts, :product_discount, :boolean
    remove_column :discounts, :shipping_discount, :boolean

    # 2. Add the new array fields (Assuming PostgreSQL)
    add_column :discounts, :selected_collection_ids, :bigint, array: true, default: []
    add_column :discounts, :selected_product_ids, :bigint, array: true, default: []
    
    # If you aren't using Postgres, use JSON instead:
    # add_column :discounts, :selected_collection_ids, :json, default: []
    # add_column :discounts, :selected_product_ids, :json, default: []
  end
end