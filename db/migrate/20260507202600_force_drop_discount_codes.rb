class ForceDropDiscountCodes < ActiveRecord::Migration[8.1]
  def change
    drop_table :discount_codes, if_exists: true
  end
end