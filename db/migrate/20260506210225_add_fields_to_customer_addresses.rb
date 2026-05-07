class AddFieldsToCustomerAddresses < ActiveRecord::Migration[7.0]
  def change
    add_column :customer_addresses, :country, :string
    add_column :customer_addresses, :first_name, :string
    add_column :customer_addresses, :last_name, :string
    add_column :customer_addresses, :company, :string
    add_column :customer_addresses, :apartment, :string
    add_column :customer_addresses, :phone, :string
  end
end