# app/controllers/storefront/cart_controller.rb
class Storefront::CartController < Storefront::BaseController
  def show
    @cart = current_cart
  end

  def add_item
    @cart    = current_cart
    variant  = @store.products
                     .joins(:product_variants)
                     .where(product_variants: { id: params[:variant_id] })
                     .first
                     &.product_variants
                     &.find(params[:variant_id])

    if variant
      item = @cart.cart_items.find_or_initialize_by(
        product_id: variant.product_id,
        product_variant_id: variant.id
      )
      item.quantity = (item.quantity || 0) + (params[:quantity]&.to_i || 1)
      item.save!
      redirect_to storefront_cart_path, notice: "Item added to cart"
    else
      redirect_to storefront_cart_path, alert: "Item not found"
    end
  end

  def remove_item
    @cart = current_cart
    item  = @cart.cart_items.find(params[:id])
    item.destroy
    redirect_to storefront_cart_path, notice: "Item removed"
  end

  private

  def current_cart
    # For now uses session-based guest cart via customer_id
    # You can expand this later for logged-in customers
    session[:cart_id] ||= Cart.create!(
      store_id:    @store.id,
      customer_id: guest_customer.id
    ).id
    Cart.find(session[:cart_id])
  end

  def guest_customer
    # Creates a temporary guest customer record for the cart
    Customer.find_or_create_by!(
      store_id: @store.id,
      email:    "guest_#{session.id}@guest.local"
    ) do |c|
      c.first_name = "Guest"
    end
  end
end