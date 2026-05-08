class AddStoreRefToDiscounts < ActiveRecord::Migration[8.1]
  def change
    add_reference :discounts, :store, null: false, foreign_key: true
  end
end
