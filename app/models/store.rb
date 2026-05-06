class Store < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :customers, through: :orders
  has_many :collections, dependent: :destroy
  has_many :carts, dependent: :destroy
  belongs_to :user
end
