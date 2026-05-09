# app/models/draft_order_item.rb
class DraftOrderItem < ApplicationRecord
  belongs_to :draft_order
  belongs_to :product, optional: true
  belongs_to :product_variant, optional: true

  def custom_item?
    product_id.nil?
  end

  def display_name
    custom_item? ? custom_title : "#{product.title} - #{product_variant.size} / #{product_variant.color}"
  end
end