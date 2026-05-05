class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.string :status
      t.decimal :subtotal
      t.decimal :shipping_price
      t.decimal :total_price
      t.references :store, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.references :shipping_method, null: false, foreign_key: true

      t.timestamps
    end
  end
end
