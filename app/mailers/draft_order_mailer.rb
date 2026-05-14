class DraftOrderMailer < ApplicationMailer
  def invoice(draft_order, email, message)
    @draft_order = draft_order
    @message     = message
    @items       = draft_order.draft_order_items.includes(:product, :product_variant)

    mail(
      to:      email,
      subject: "Invoice for Order #D#{draft_order.id}"
    )
  end
end