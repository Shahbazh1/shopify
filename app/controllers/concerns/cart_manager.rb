module CartManager
  extend ActiveSupport::Concern

  included do
    helper_method :current_cart
  end

  def current_cart
    return @current_cart if defined?(@current_cart)
    return nil unless current_customer

    @current_cart =
      current_customer.cart ||
      current_customer.create_cart(store: @store)
  end
end