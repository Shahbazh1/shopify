class CreateDiscounts < ActiveRecord::Migration[8.1]
  def change
    create_table :discounts do |t|
      t.string :type
      t.decimal :value
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
