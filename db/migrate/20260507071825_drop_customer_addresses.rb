class DropCustomerAddresses < ActiveRecord::Migration[8.1]
  def change
    drop_table :customer_addresses
  end
end