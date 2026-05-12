# app/controllers/storefront/base_controller.rb
class Storefront::BaseController < ApplicationController
  before_action :set_store
  layout "storefront"

  helper_method :current_customer, :current_cart

  private

  def set_store
    @store = Store.find_by!(slug: request.subdomain)
  rescue ActiveRecord::RecordNotFound
    render file: Rails.root.join("public/404.html"),
           status: :not_found,
           layout: false
  end

  def current_cart
    return @current_cart if defined?(@current_cart)

    # 1. Try to load existing cart from session
    @current_cart = if session[:cart_id]
      Cart.includes(:customer).find_by(id: session[:cart_id], store: @store)
    end

    # 2. If no cart exists, create a new one
    unless @current_cart
      customer = current_customer

      unless customer
        redirect_to new_customer_session_path,
                    alert: "Please login to continue" and return
      end

      @current_cart = Cart.create!(
        store: @store,
        customer: customer
      )

      session[:cart_id] = @current_cart.id
    end

    @current_cart
  end
end