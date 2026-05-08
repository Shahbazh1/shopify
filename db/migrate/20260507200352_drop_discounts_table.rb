class DropDiscountsTable < ActiveRecord::Migration[8.1]
  def change
    drop_table :discounts
    drop_table :discount_usages
    drop_table :discount_codes
  end
end