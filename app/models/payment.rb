class Payment < ApplicationRecord
  belongs_to :order
  has_one :refund, dependent: :destroy
end
