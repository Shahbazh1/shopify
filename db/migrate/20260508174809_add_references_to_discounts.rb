class AddReferencesToDiscounts < ActiveRecord::Migration[8.1]
  def change
    add_reference :discounts, :product, null: true, foreign_key: true
    add_reference :discounts, :collection, null: true, foreign_key: true
  end
end
