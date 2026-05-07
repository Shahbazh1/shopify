class AddAddressFieldsToCustomers < ActiveRecord::Migration[8.0]
  def change
    add_column :customers, :company, :string
    add_column :customers, :address, :text
    add_column :customers, :apartment, :string
    add_column :customers, :city, :string
    add_column :customers, :country, :string
    add_column :customers, :postal_code, :string
    add_column :customers, :is_default, :boolean, default: false
  end
end