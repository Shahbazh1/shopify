class AddDiscountTitleToDiscounts < ActiveRecord::Migration[8.1]
  def change
    add_column :discounts, :discount_title, :string
  end
end
