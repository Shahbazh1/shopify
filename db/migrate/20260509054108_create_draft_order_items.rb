class CreateDraftOrderItems < ActiveRecord::Migration[8.1]
  # rails generate migration CreateDraftOrderItems
def change
  create_table :draft_order_items do |t|
    t.bigint  :draft_order_id,     null: false
    t.bigint  :product_id                        # null for custom items
    t.bigint  :product_variant_id                # null for custom items
    t.string  :custom_title                      # only for custom items
    t.decimal :price,    precision: 10, scale: 2
    t.integer :quantity, default: 1
    t.timestamps
  end

  add_index :draft_order_items, :draft_order_id

  add_foreign_key :draft_order_items, :draft_orders
  add_foreign_key :draft_order_items, :products
  add_foreign_key :draft_order_items, :product_variants
end
end
