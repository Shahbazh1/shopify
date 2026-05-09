class RemoveInvoiceMessageFromDraftOrders < ActiveRecord::Migration[8.1]
  def change
    remove_column :draft_orders, :invoice_message, :text
  end
end
