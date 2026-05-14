class Storefront::CheckoutController < Storefront::BaseController
  before_action :set_cart

  def show
  if @cart.cart_items.empty?
    redirect_to storefront_cart_path, alert: "Your cart is empty."
    return
  end

  @cart_items      = @cart.cart_items.includes(:product, :product_variant)
  @discount_result = Discounts::ApplyService.new(@store, @cart, nil).call
  @subtotal        = @discount_result[:subtotal]
  @order_discount  = @discount_result[:order_discount]
  @shipping_price  = @discount_result[:shipping_discount] == :free ? 0 : 5.00
  @total           = [@subtotal + @shipping_price - @order_discount, 0].max
end

  def create_stripe_session
    return redirect_to storefront_cart_path, alert: "Your cart is empty." if @cart.cart_items.empty?

  customer        = current_customer
  discount_result = Discounts::ApplyService.new(
    @store,
    @cart,
    checkout_params[:discount_code]
  ).call

    Rails.logger.debug "=== DISCOUNT RESULT: #{discount_result.inspect}"  # ← add this


  subtotal       = discount_result[:subtotal]          # ← was: @cart.cart_items.sum { ... }
  shipping_price = discount_result[:shipping_discount] == :free ? 0 : 5.00
  discount_total = discount_result[:order_discount]
  total          = [subtotal + shipping_price - discount_total, 0].max

    Rails.logger.debug "=== TOTAL: #{total}"  # ← and this


  order = Order.create!(
    store:              @store,
    customer:           customer,
    shipping_price:     shipping_price,
    subtotal:           subtotal,
    total_price:        total,
    payment_status:     "pending",
    fulfillment_status: "pending",
    order_status:       "pending",
    first_name:         checkout_params[:first_name],
    last_name:          checkout_params[:last_name],
    phone:              checkout_params[:phone],
    email:              checkout_params[:email],
    shipping_address:   checkout_params[:address],
    city:               checkout_params[:city],
    country:            checkout_params[:country],
    postal_code:        checkout_params[:postal_code]
  )

  @cart.cart_items.each do |item|
    OrderItem.create!(
      order:           order,
      product:         item.product,
      product_variant: item.product_variant,
      quantity:        item.quantity,
      price:           item.product_variant.price
    )
  end

  # Single line item = exactly what customer owes after discount
  line_items = [
    {
      price_data: {
        currency:     @store.currency.downcase,
        unit_amount:  (total * 100).to_i,
        product_data: { name: "Order ##{order.id} — #{@store.name}" }
      },
      quantity: 1
    }
  ]

  session = Stripe::Checkout::Session.create(
    payment_method_types: ["card"],
    line_items:           line_items,
    mode:                 "payment",
    customer_email:       customer.email,
    success_url: storefront_checkout_success_url(host: request.host_with_port) + "?session_id={CHECKOUT_SESSION_ID}",
    cancel_url:  storefront_checkout_cancel_url(host: request.host_with_port),
    metadata: {
      order_id: order.id,
      store_id: @store.id
    }
  )

  order.update!(stripe_session_id: session.id)
  redirect_to session.url, allow_other_host: true

rescue ActiveRecord::RecordInvalid => e
  flash[:alert] = "Something went wrong: #{e.message}"
  redirect_to storefront_checkout_path
end   

  # Stripe redirects here after successful payment
  # DO NOT trust this to confirm payment — use the webhook for that
  def success
    @order = Order.find_by(stripe_session_id: params[:session_id], store: @store)
    # Just show a "thank you" page; actual fulfillment happens in webhook
  end

  def cancel
    flash[:alert] = "Payment was cancelled. Your cart is still saved."
    redirect_to storefront_cart_path
  end

  private

  def set_cart
    @store    = Store.find_by!(slug: request.subdomain)
    customer  = current_customer
    @cart     = Cart.find_or_create_by(store: @store, customer: customer)
  end

  def checkout_params
    params.require(:checkout).permit(
      :first_name, :last_name, :email, :phone,
      :address, :city, :country, :postal_code,
      :shipping_method_id, :discount_code
    )
  end
end