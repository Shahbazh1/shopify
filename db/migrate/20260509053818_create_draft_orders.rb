class CreateDraftOrders < ActiveRecord::Migration[8.1]
  # rails generate migration CreateDraftOrders
def change
  create_table :draft_orders do |t|
    t.bigint  :store_id,        null: false
    t.bigint  :customer_id                        # optional until customer selected
    t.string  :status,          default: 'open'   # open | invoice_sent | completed | cancelled
    t.string  :payment_method                     # invoice | cod | mark_paid
    t.decimal :subtotal,        precision: 10, scale: 2, default: 0
    t.decimal :discount_amount, precision: 10, scale: 2, default: 0
    t.string  :discount_type                      # fixed | percent
    t.decimal :shipping_price,  precision: 10, scale: 2, default: 0
    t.decimal :total_price,     precision: 10, scale: 2, default: 0
    t.string  :invoice_subject
    t.text    :invoice_message
    t.datetime :invoice_sent_at
    t.boolean :lock_prices,     default: true
    t.timestamps
  end

  add_index :draft_orders, :store_id
  add_index :draft_orders, :customer_id
  add_index :draft_orders, :status

  add_foreign_key :draft_orders, :stores
  add_foreign_key :draft_orders, :customers
end
end
