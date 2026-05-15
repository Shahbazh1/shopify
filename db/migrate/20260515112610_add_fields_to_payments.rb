class AddFieldsToPayments < ActiveRecord::Migration[8.1]
  def change
    add_column :payments, :currency, :string
    add_column :payments, :stripe_session_id, :string
  end
end
