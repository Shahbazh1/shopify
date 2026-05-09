class RemoveTypeFromDiscounts < ActiveRecord::Migration[8.1]
  def change
    remove_column :discounts, :type, :string
  end
end