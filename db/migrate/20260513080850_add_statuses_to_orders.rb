class AddStatusesToOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :payment_status, :string, default: "pending"
    add_column :orders, :fulfillment_status, :string, default: "pending"
    add_column :orders, :order_status, :string, default: "pending"

    remove_column :orders, :status, :string
  end
end