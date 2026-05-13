module Checkouts
  class CartsIndexQuery
    def initialize(store)
      @store = store
    end

    def call
      @store.carts.includes(
        :customer,
        cart_items: [:product, :product_variant]
      )
    end
  end

 class CartItemIndexQuery
    def initialize(store)
      @store = store
    end

    def call
      CartItem
        .joins(cart: :store)
        .where(carts: { store_id: @store.id })
        .includes(:product, :product_variant)
   end
  end
end