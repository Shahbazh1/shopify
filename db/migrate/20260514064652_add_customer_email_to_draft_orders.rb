class AddCustomerEmailToDraftOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :draft_orders, :customer_email, :string
  end
end
