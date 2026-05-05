class CreateProductVariants < ActiveRecord::Migration[8.1]
  def change
    create_table :product_variants do |t|
      t.decimal :price
      t.string :size
      t.string :color
      t.integer :stock_quantity
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
