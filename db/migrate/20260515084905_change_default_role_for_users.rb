class ChangeDefaultRoleForUsers < ActiveRecord::Migration[8.1]
  def change
    change_column_default :users, :role, "member"
  end
end
