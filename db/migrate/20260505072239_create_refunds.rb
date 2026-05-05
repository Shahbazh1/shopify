class CreateRefunds < ActiveRecord::Migration[8.1]
  def change
    create_table :refunds do |t|
      t.decimal :amount
      t.text :reason
      t.references :payment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
