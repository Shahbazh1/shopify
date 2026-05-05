class CreateShipments < ActiveRecord::Migration[8.1]
  def change
    create_table :shipments do |t|
      t.string :tracking_number
      t.string :status
      t.datetime :shipped_at
      t.datetime :delivered_at
      t.references :order, null: false, foreign_key: true
      t.references :shipping_method, null: false, foreign_key: true

      t.timestamps
    end
  end
end
