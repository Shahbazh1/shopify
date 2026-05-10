class Order < ApplicationRecord
  belongs_to :store
  belongs_to :customer
  belongs_to :shipping_method
  has_many :order_items, dependent: :destroy
  has_one :shipment, dependent: :destroy
  has_one :payment, dependent: :destroy

  STATUSES = [
    "pending",
    "paid",
    "processing",
    "shipped",
    "completed",
    "cancelled"
  ]
end
