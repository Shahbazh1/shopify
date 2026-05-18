module CartManager
  extend ActiveSupport::Concern

  included do
    helper_method :current_cart
  end

  def current_cart
    return @current_cart if defined?(@current_cart)

    @current_cart = load_cart_from_session || find_or_create_cart
  end

  private

  def load_cart_from_session
    return nil unless session[:cart_id]

    Cart.includes(:customer)
        .find_by(id: session[:cart_id], store: @store)
  end

  def find_or_create_cart
    customer = current_customer

    # ❗ IMPORTANT: no redirect inside helper
    return nil unless customer

    cart = Cart.create!(
      store: @store,
      customer: customer
    )

    session[:cart_id] = cart.id
    cart
  end
end