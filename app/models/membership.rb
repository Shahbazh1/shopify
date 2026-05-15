class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :store

  enum :role, { member: "member", admin: "admin" }
end
