class CreateCollectionDiscounts < ActiveRecord::Migration[8.1]
  def change
    create_table :collection_discounts do |t|
      t.references :collection, null: false, foreign_key: true
      t.references :discount, null: false, foreign_key: true

      t.timestamps
    end
  end
end
