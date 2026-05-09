class UpdateCustomersStructure < ActiveRecord::Migration[8.1]
  def change
    # 1. Add store reference
    add_reference :customers, :store, null: false, foreign_key: true

    # 2. Rename name → first_name
    rename_column :customers, :name, :first_name

    # 3. Add new columns
    add_column :customers, :last_name, :string
    add_column :customers, :language, :string, default: "en"
  end
end