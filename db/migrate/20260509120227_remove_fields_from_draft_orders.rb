class RemoveFieldsFromDraftOrders < ActiveRecord::Migration[8.1]
   def change
    remove_reference :draft_orders, :customer, foreign_key: true

    remove_column :draft_orders, :discount_type, :string
    remove_column :draft_orders, :invoice_sent_at, :datetime
    remove_column :draft_orders, :invoice_subject, :string
    remove_column :draft_orders, :lock_prices, :boolean
    remove_column :draft_orders, :payment_method, :string

    remove_index :draft_orders, :status if index_exists?(:draft_orders, :status)
  end
end
