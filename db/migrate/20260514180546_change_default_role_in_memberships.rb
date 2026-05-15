class ChangeDefaultRoleInMemberships < ActiveRecord::Migration[8.1]
  def change
    change_column_default :memberships, :role, from: "staff", to: "member"
  end
end
