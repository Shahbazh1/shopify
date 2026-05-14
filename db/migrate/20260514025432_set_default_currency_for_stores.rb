class SetDefaultCurrencyForStores < ActiveRecord::Migration[8.1]
  def change
    change_column_default :stores, :currency, "PKR"
  end
end
