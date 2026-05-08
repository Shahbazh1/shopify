class RemoveTypeFromDiscounts < ActiveRecord::Migration[7.1]
  def change
    remove_column :discounts, :type, :string
  end
end