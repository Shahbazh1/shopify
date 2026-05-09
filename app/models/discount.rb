class Discount < ApplicationRecord
  belongs_to :store

  has_many :product_discounts, dependent: :destroy
  has_many :products, through: :product_discounts

  has_many :collection_discounts, dependent: :destroy
  has_many :collections, through: :collection_discounts

  accepts_nested_attributes_for :product_discounts, allow_destroy: true
  accepts_nested_attributes_for :collection_discounts, allow_destroy: true
end  