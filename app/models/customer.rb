class Customer < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :stores, through: :orders
  has_many :customer_addresses, dependent: :destroy
  has_many :discount_usages, dependent: :destroy
  has_many :carts, dependent: :destroy
end