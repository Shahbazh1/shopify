class Discounts::ApplyService
  def initialize(store, cart, code = nil)
    @store = store
    @cart  = cart
    @code  = code
  end

  def call
    subtotal          = calculate_subtotal
    shipping_discount = 0
    order_discount    = 0

    valid_discounts.each do |discount|

      case discount.discount_type

      when "amount_off_order"
        order_discount += apply_order_discount(discount, subtotal)

      when "free_shipping"
        shipping_discount = :free
      end
    end

    {
      subtotal: subtotal,
      order_discount: order_discount,
      shipping_discount: shipping_discount
    }
  end

  private

  def cart_items
    @cart_items ||= @cart.cart_items.includes(:product_variant)
  end

  def calculate_subtotal
    cart_items.sum do |item|
      item.product_variant.price * item.quantity
    end
  end

  def valid_discounts
  base = @store.discounts
    .where("start_date <= ?", Date.today)
    .where("end_date IS NULL OR end_date >= ?", Date.today)

  if @code.present?
    normalized = @code.to_s.strip.downcase
    base.where(
      "discount_method = 'automatic' OR (discount_method = 'code' AND LOWER(discount_code) = ?)",
      normalized
    )
  else
    base.where(discount_method: "automatic")
  end
end

  def apply_order_discount(discount, subtotal)

    if discount.value_type == "percentage"

      subtotal * (discount.value / 100.0)

    else

      # fixed amount discount
      [discount.value, subtotal].min
    end
  end
end