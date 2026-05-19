class DropRefunds < ActiveRecord::Migration[8.1]
  def change
    drop_table :refunds
  end
end
