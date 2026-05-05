class DiscountUsage < ApplicationRecord
  belongs_to :discount_code
  belongs_to :customer
  belongs_to :order
end
