class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  belongs_to :product_variant
end

# OrderItem Model Missing Associations:
# Migration: order_items table has product_id and product_variant_id with foreign keys.
# Model: Only belongs_to :order defined.
# Issue: Missing belongs_to :product and belongs_to :product_variant in OrderItem model.
