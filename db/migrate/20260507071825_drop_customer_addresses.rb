class DropCustomerAddresses < ActiveRecord::Migration[8.0]
  def change
    drop_table :customer_addresses
  end
end