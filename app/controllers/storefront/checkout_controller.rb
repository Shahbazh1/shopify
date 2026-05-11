class Storefront::CheckoutController < Storefront::BaseController
  before_action :set_cart

  def index
    # You need to fetch the store context here
    @store = Store.find(params[:store_id])
    @orders = @store.orders # Or however you are fetching orders
  end

  def show
    if @cart.cart_items.empty?
      redirect_to storefront_cart_path,
                  alert: "Your cart is empty."
      return
    end

    @cart_items = @cart.cart_items.includes(:product, :product_variant)

    @subtotal = @cart_items.sum do |item|
      item.product_variant.price * item.quantity
    end

    @shipping_methods = ShippingMethod.all
  end

  def create
    if @cart.cart_items.empty?
      redirect_to storefront_cart_path,
                  alert: "Your cart is empty."
      return
    end

    # 1 — Find or create customer
    customer = Customer.find_or_create_by!(
      store_id: @store.id,
      email: checkout_params[:email]
    ) do |c|
      c.first_name  = checkout_params[:first_name]
      c.last_name   = checkout_params[:last_name]
      c.phone       = checkout_params[:phone]
      c.address     = checkout_params[:address]
      c.city        = checkout_params[:city]
      c.country     = checkout_params[:country]
      c.postal_code = checkout_params[:postal_code]
    end

    # 2 — Shipping method
    shipping_method = ShippingMethod.find(
      checkout_params[:shipping_method_id]
    )

    # 3 — Totals
    subtotal = @cart.cart_items.sum do |item|
      item.product_variant.price * item.quantity
    end

    total = subtotal + shipping_method.price

    # 4 — Create order
    order = Order.create!(
      store: @store,
      customer: customer,
      shipping_method: shipping_method,
      shipping_price: shipping_method.price,
      subtotal: subtotal,
      total_price: total,
      status: "pending"
    )

    # 5 — Create order items
    @cart.cart_items.each do |item|
      OrderItem.create!(
        order: order,
        product: item.product,
        product_variant: item.product_variant,
        quantity: item.quantity,
        price: item.product_variant.price
      )
    end

    # 6 — Clear cart
    @cart.cart_items.destroy_all

    # 7 — Redirect
    redirect_to storefront_root_path,
                notice: "Order placed successfully!"

  rescue ActiveRecord::RecordInvalid => e
    flash[:alert] = "Something went wrong: #{e.message}"
    redirect_to storefront_checkout_path
  end

  private

  def set_cart
    @store = Store.find_by(slug: request.subdomain)

    unless @store
      raise ActiveRecord::RecordNotFound,
            "Store not found for subdomain: #{request.subdomain}"
    end

    customer = Customer.first

    @cart = Cart.find_or_create_by(
      store: @store,
      customer: customer
    )
  end

  def checkout_params
    params.require(:checkout).permit(
      :first_name,
      :last_name,
      :email,
      :phone,
      :address,
      :city,
      :country,
      :postal_code,
      :shipping_method_id
    )
  end
end