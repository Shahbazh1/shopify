class Order < ApplicationRecord
  belongs_to :store
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_one :payment, dependent: :destroy

end
