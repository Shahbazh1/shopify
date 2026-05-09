class AddOrdersCountToCustomers < ActiveRecord::Migration[8.1]
  def change
    add_column :customers, :orders_count, :integer, default: 0, null: false
  end
end