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
end