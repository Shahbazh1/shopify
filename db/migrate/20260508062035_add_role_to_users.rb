# db/migrate/20260508XXXXXX_add_role_to_users.rb
class AddRoleToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :role, :string, default: "user"
  end
end