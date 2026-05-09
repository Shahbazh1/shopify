class Discount < ApplicationRecord
  belongs_to :store
  belongs_to :product, optional: true
  belongs_to :collection, optional: true
end  