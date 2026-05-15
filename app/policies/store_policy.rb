# app/policies/store_policy.rb
class StorePolicy < ApplicationPolicy
  # record = the Store

  def update?
    admin_of_store?
  end

  def manage_members?
    admin_of_store?
  end

  private

  def admin_of_store?
    record.memberships.exists?(user: user, role: "admin")
  end
end