class RemoveMaxUsageLimitFromDiscounts < ActiveRecord::Migration[8.1]
   def change
    remove_column :discounts, :max_usage_limit, :integer
  end
end
