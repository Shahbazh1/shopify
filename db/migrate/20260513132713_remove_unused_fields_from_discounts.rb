class RemoveUnusedFieldsFromDiscounts < ActiveRecord::Migration[8.1]
   def change
    remove_column :discounts, :customer_eligibility, :string
    remove_column :discounts, :minimum_requirement_type, :string
    remove_column :discounts, :minimum_purchase_amount, :decimal
    remove_column :discounts, :minimum_quantity, :integer
    remove_column :discounts, :code_type, :string
  end
end
