class Storefront::CartController < Storefront::BaseController
  before_action :authenticate_customer!
  before_action :set_cart

  def show
  end

  def add_item
    variant = ProductVariant.find(params[:variant_id])
    product = variant.product

    quantity = params[:quantity].to_i
    quantity = 1 if quantity <= 0

    cart_item = @cart.cart_items.find_by(product_variant_id: variant.id)

    if cart_item
      cart_item.update(quantity: cart_item.quantity + quantity)
    else
      @cart.cart_items.create!(
        product: product,
        product_variant: variant,
        quantity: quantity
      )
    end

    redirect_to storefront_cart_path,
                notice: "Item added to cart"
  end

  def remove_item
    item = @cart.cart_items.find(params[:id])
    item.destroy

    redirect_to storefront_cart_path,
                notice: "Item removed"
  end

  private

  def set_cart
    @cart = current_cart
  end
end