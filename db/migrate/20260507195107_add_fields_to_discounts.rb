class AddFieldsToDiscounts < ActiveRecord::Migration[8.1]
  def change
    add_column :discounts, :discount_type, :string
    add_column :discounts, :discount_method, :string

    add_column :discounts, :code_type, :string
    add_column :discounts, :discount_code, :string
    add_column :discounts, :auto_generate_code, :boolean, default: false

    add_column :discounts, :value_type, :string

    add_column :discounts, :applies_to, :string
    add_column :discounts, :customer_eligibility, :string

    add_column :discounts, :minimum_requirement_type, :string
    add_column :discounts, :minimum_purchase_amount, :decimal
    add_column :discounts, :minimum_quantity, :integer

    add_column :discounts, :max_usage_limit, :integer
    add_column :discounts, :limit_one_per_customer, :boolean, default: false

    add_column :discounts, :product_discount, :boolean, default: false
    add_column :discounts, :order_discount, :boolean, default: false
    add_column :discounts, :shipping_discount, :boolean, default: false

    
  end
end