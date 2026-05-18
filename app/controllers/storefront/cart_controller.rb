class Storefront::CartController < Storefront::BaseController
  before_action :set_cart
  before_action :authenticate_customer!

  def show
  end

  def add_item
    variant = ProductVariant.find(params[:variant_id])

    quantity = params[:quantity].to_i
    quantity = 1 if quantity <= 0

    begin
      Cart::AddItemService.new(
        cart: @cart,
        variant: variant,
        quantity: quantity
      ).call

      redirect_back fallback_location: storefront_cart_path,
                    notice: "Item added to cart."

    rescue Cart::AddItemService::OutOfStockError
      redirect_back fallback_location: storefront_product_path(variant.product.slug),
                    alert: "This product is out of stock."

    rescue Cart::AddItemService::StockLimitError
      redirect_back fallback_location: storefront_product_path(variant.product.slug),
                    alert: "Only #{variant.stock_quantity} items available."
    end
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