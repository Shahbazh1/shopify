class AddUpdatedByToOrders < ActiveRecord::Migration[8.1]
  def change
    add_reference :orders,
                  :updated_by,
                  foreign_key: { to_table: :users }
  end
end
