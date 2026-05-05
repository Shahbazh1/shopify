class CreateDiscountUsages < ActiveRecord::Migration[8.1]
  def change
    create_table :discount_usages do |t|
      t.references :discount_code, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.datetime :used_at

      t.timestamps
    end
  end
end
