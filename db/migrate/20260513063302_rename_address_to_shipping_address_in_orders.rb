class RenameAddressToShippingAddressInOrders < ActiveRecord::Migration[8.1]
  def change
    rename_column :orders, :address, :shipping_address
  end
end
