# app/controllers/storefront/stripe_webhooks_controller.rb
class Storefront::StripeWebhooksController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def create
    payload    = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, ENV['STRIPE_WEBHOOK_SECRET']
      )
    rescue JSON::ParserError, Stripe::SignatureVerificationError => e
      render json: { error: e.message }, status: :bad_request
      return
    end

    case event['type']
    when 'checkout.session.completed'
      handle_checkout_completed(event['data']['object'])
    end

    render json: { received: true }
  end

  private

  def handle_checkout_completed(session)

  order = Order.find_by(
    stripe_session_id: session['id']
  )

  return unless order

  # Prevent duplicate webhook calls
  return if order.payment_status == "paid"

  ActiveRecord::Base.transaction do

    # =========================
    # MARK ORDER AS PAID
    # =========================
    order.update!(
      payment_status: "paid",
      fulfillment_status: "pending",
      order_status: "processing"
    )

    # =========================
    # CREATE PAYMENT RECORD
    # =========================
    Payment.create!(
      order:             order,
      amount:            session['amount_total'] / 100.0,
      currency:          session['currency'],        
      payment_method:    'stripe',
      status:            'paid',
      transaction_id:    session['payment_intent'],
      stripe_session_id: session['id']                
    )

    # =========================
    # REDUCE STOCK
    # =========================
    order.order_items.each do |item|

      variant = item.product_variant

      variant.with_lock do

        # Safety check
        if variant.stock_quantity < item.quantity
          raise ActiveRecord::Rollback,
                "Not enough stock"
        end

        variant.update!(
          stock_quantity:
            variant.stock_quantity - item.quantity
        )
      end
    end

    # =========================
    # CLEAR CUSTOMER CART
    # =========================
    cart = Cart.find_by(
      store: order.store,
      customer: order.customer
    )

    cart&.cart_items&.destroy_all
  end
end
end