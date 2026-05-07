class Customer < ApplicationRecord
  belongs_to :store

  has_many :orders, dependent: :destroy
  has_many :discount_usages, dependent: :destroy
  has_many :carts, dependent: :destroy

end