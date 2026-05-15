class CreateMemberships < ActiveRecord::Migration[8.1]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :store, null: false, foreign_key: true
      t.string :role, default: "staff"

      t.timestamps
    end
    add_index :memberships, [:user_id, :store_id], unique: true
  end
end
