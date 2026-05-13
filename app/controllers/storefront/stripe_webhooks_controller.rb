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
    order = Order.find_by(stripe_session_id: session['id'])
    return unless order

    # Mark order as paid
    order.update!(status: 'paid')

    # Record payment
    Payment.create!(
      order:          order,
      amount:         session['amount_total'] / 100.0,
      payment_method: 'stripe',
      status:         'paid',
      transaction_id: session['payment_intent']
    )

    # Clear the customer's cart
    cart = Cart.find_by(store: order.store, customer: order.customer)
    cart&.cart_items&.destroy_all
  end
end