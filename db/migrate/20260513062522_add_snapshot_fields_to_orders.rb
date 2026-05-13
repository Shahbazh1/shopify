class AddSnapshotFieldsToOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :first_name, :string
    add_column :orders, :last_name, :string
    add_column :orders, :phone, :string
    add_column :orders, :email, :string

    add_column :orders, :address, :text
    add_column :orders, :city, :string
    add_column :orders, :country, :string
    add_column :orders, :postal_code, :string
  end
end
