class Product < ApplicationRecord
  belongs_to :store
  has_many :product_images, dependent: :destroy
  has_many :product_variants, dependent: :destroy
  has_many :collections, through: :product_collections
  has_many :order_items, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  accepts_nested_attributes_for :product_variants, allow_destroy: true
  accepts_nested_attributes_for :product_images, allow_destroy: true
end
