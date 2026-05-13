class Storefront::CheckoutController < Storefront::BaseController
  before_action :set_cart

  def show
    if @cart.cart_items.empty?
      redirect_to storefront_cart_path, alert: "Your cart is empty."
      return
    end

    @cart_items    = @cart.cart_items.includes(:product, :product_variant)
    @subtotal      = @cart_items.sum { |i| i.product_variant.price * i.quantity }
    @shipping_methods = ShippingMethod.all
  end

  def create_stripe_session
    if @cart.cart_items.empty?
      redirect_to storefront_cart_path, alert: "Your cart is empty."
      return
    end

    customer       = current_customer
    shipping_method = ShippingMethod.find(checkout_params[:shipping_method_id])

    customer.update!(
      first_name:  checkout_params[:first_name],
      last_name:   checkout_params[:last_name],
      phone:       checkout_params[:phone],
      address:     checkout_params[:address],
      city:        checkout_params[:city],
      country:     checkout_params[:country],
      postal_code: checkout_params[:postal_code]
    )

    subtotal = @cart.cart_items.sum { |i| i.product_variant.price * i.quantity }
    total    = subtotal + shipping_method.price

    # Create order with status "pending_payment" before Stripe
    order = Order.create!(
      store:           @store,
      customer:        customer,
      shipping_method: shipping_method,
      shipping_price:  shipping_method.price,
      subtotal:        subtotal,
      total_price:     total,
      status:          "pending_payment"
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

    # Build Stripe line items from cart
    line_items = @cart.cart_items.map do |item|
      variant = item.product_variant
      {
        price_data: {
          currency:     @store.currency.downcase,
          unit_amount:  (variant.price * 100).to_i,  # Stripe wants cents
          product_data: {
            name: "#{item.product.title} — #{[variant.size, variant.color].compact.join(' / ')}"
          }
        },
        quantity: item.quantity
      }
    end

    # Add shipping as a line item
    line_items << {
      price_data: {
        currency:     @store.currency.downcase,
        unit_amount:  (shipping_method.price * 100).to_i,
        product_data: { name: "Shipping — #{shipping_method.name}" }
      },
      quantity: 1
    }

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items:           line_items,
      mode:                 'payment',
      customer_email:       customer.email,
      success_url: storefront_checkout_success_url(host: request.host_with_port) + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:  storefront_checkout_cancel_url(host: request.host_with_port),
      metadata: {
        order_id: order.id,
        store_id: @store.id
      }
    )

    # Save the stripe session id so webhook can find the order
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
      :shipping_method_id
    )
  end
end