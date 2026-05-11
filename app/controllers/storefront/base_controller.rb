# app/controllers/storefront/base_controller.rb
class Storefront::BaseController < ApplicationController
  skip_before_action :authenticate_user!  # storefront is public
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

  def current_customer
    return @current_customer if defined?(@current_customer)

    @current_customer = if session[:customer_id]
      Customer.find_by(id: session[:customer_id], store: @store)
    end
  end

  def current_cart
    return @current_cart if defined?(@current_cart)

    @current_cart = if session[:cart_id]
      Cart.includes(:customer).find_by(id: session[:cart_id], store: @store)
    end

    unless @current_cart
      customer = current_customer || create_guest_customer
      @current_cart = Cart.create!(store: @store, customer: customer)
      session[:cart_id] = @current_cart.id
      session[:customer_id] = customer.id
    end

    @current_cart
  end

  def create_guest_customer
    customer = @store.customers.create!(first_name: "Guest", last_name: "Customer", email: "guest-#{SecureRandom.uuid}@example.com")
    @current_customer = customer
  end
end