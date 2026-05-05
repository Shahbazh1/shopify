class DiscountCode < ApplicationRecord
  belongs_to :discount
  has_many :discount_usages
end
