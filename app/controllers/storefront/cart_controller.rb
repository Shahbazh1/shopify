class Storefront::CartController < Storefront::BaseController
  before_action :set_cart
  before_action :authenticate_customer!

  def show
  end

  def add_item
    variant = ProductVariant.find(params[:variant_id])
    product = variant.product

    quantity = params[:quantity].to_i
    quantity = 1 if quantity <= 0

    cart_item = @cart.cart_items.find_by(
      product_variant_id: variant.id
    )

    current_cart_quantity = cart_item&.quantity || 0

    new_quantity = current_cart_quantity + quantity

    # STOCK CHECK
    if variant.stock_quantity <= 0
      redirect_back fallback_location: storefront_product_path(product.slug),
                    alert: "This product is out of stock."
      return
    end

    if new_quantity > variant.stock_quantity
      redirect_back fallback_location: storefront_product_path(product.slug),
                    alert: "Only #{variant.stock_quantity} items available in stock."
      return
    end

    if cart_item
      cart_item.update(quantity: new_quantity)
    else
      @cart.cart_items.create!(
        product: product,
        product_variant: variant,
        quantity: quantity
      )
    end

    redirect_back fallback_location: storefront_cart_path,
                  notice: "Item added to cart."
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