# app/controllers/storefront/checkout_controller.rb
class Storefront::CheckoutController < Storefront::BaseController
  def show
    @cart = Cart.find_by(id: session[:cart_id])
    redirect_to storefront_cart_path, alert: "Your cart is empty" if @cart.nil?
  end

  def create
    @cart = Cart.find(session[:cart_id])
    # Order creation logic goes here in next steps
    redirect_to storefront_root_path, notice: "Order placed successfully!"
  end
end