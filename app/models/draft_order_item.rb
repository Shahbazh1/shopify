# app/models/draft_order_item.rb
class DraftOrderItem < ApplicationRecord
  belongs_to :draft_order
  belongs_to :product, optional: true
  belongs_to :product_variant, optional: true

end