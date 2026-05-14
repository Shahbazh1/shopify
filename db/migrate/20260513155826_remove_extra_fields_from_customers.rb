class RemoveExtraFieldsFromCustomers < ActiveRecord::Migration[8.1]
   def change
    remove_column :customers, :address, :text
    remove_column :customers, :apartment, :string
    remove_column :customers, :city, :string
    remove_column :customers, :company, :string
    remove_column :customers, :country, :string

    remove_column :customers, :first_name, :string
    remove_column :customers, :last_name, :string
    remove_column :customers, :language, :string

    remove_column :customers, :phone, :string
    remove_column :customers, :postal_code, :string
  end
end
