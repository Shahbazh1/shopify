class CreateStores < ActiveRecord::Migration[8.1]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :slug
      t.string :domain
      t.string :currency
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
