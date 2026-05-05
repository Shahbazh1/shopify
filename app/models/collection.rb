class Collection < ApplicationRecord
  belongs_to :store
  has_many :products, through: :product_collections, dependent: :destroy
end
