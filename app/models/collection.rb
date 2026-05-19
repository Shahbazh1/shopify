class Collection < ApplicationRecord
  belongs_to :store

  has_many :product_collections, dependent: :destroy
  has_many :products, through: :product_collections

  accepts_nested_attributes_for :product_collections, allow_destroy: true
end