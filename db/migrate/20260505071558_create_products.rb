class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :slug
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
