class ShippingMethod < ApplicationRecord
  has_many :shipments dependent: :destroy
  has_many :orders, through: :shipments
end
