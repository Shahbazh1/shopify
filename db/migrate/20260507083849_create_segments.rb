class CreateSegments < ActiveRecord::Migration[8.1]
  def change
    create_table :segments do |t|
      t.string :name
      t.string :rule_type
      t.string :rule_value

      t.timestamps
    end
  end
end
