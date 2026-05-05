class CreateCustomerAddresses < ActiveRecord::Migration[8.1]
  def change
    create_table :customer_addresses do |t|
      t.text :address
      t.string :city
      t.string :postal_code
      t.boolean :is_default
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
