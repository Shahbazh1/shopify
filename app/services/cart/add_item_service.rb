class Cart::AddItemService
  def initialize(cart:, variant:, quantity:)
    @cart = cart
    @variant = variant
    @quantity = quantity.to_i
  end

  def call
    raise OutOfStockError if @variant.stock_quantity <= 0
    raise StockLimitError if exceeds_stock?

    add_or_update_item
  end

  private

  def current_item
    @cart.cart_items.find_by(product_variant_id: @variant.id)
  end

  def new_quantity
    existing = current_item&.quantity || 0
    existing + @quantity
  end

  def exceeds_stock?
    new_quantity > @variant.stock_quantity
  end

  def add_or_update_item
    if current_item
      current_item.update!(quantity: new_quantity)
    else
      @cart.cart_items.create!(
        product: @variant.product,
        product_variant: @variant,
        quantity: @quantity
      )
    end
  end

  class OutOfStockError < StandardError; end
  class StockLimitError < StandardError; end
end