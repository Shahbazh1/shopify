class CreateDiscountCodes < ActiveRecord::Migration[8.1]
  def change
    create_table :discount_codes do |t|
      t.string :code
      t.integer :usage_limit
      t.references :discount, null: false, foreign_key: true

      t.timestamps
    end
  end
end
