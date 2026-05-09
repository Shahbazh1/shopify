# app/models/draft_order.rb
class DraftOrder < ApplicationRecord
  belongs_to :store
  has_many :draft_order_items, dependent: :destroy

  accepts_nested_attributes_for :draft_order_items, allow_destroy: true

  enum :status, { open: 'open', completed: 'completed', cancelled: 'cancelled' }

end