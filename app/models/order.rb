class Order < ApplicationRecord
  belongs_to :store
  belongs_to :customer
  belongs_to :updated_by, class_name: "User", optional: true
  has_many :order_items, dependent: :destroy
  has_one :payment, dependent: :destroy

end
