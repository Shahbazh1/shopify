module Checkouts
  class CartShowQuery
    def initialize(store, id)
      @store = store
      @id = id
    end

    def call
      @store.carts
            .includes(cart_items: [:product, :product_variant])
            .find(@id)
    end
  end
end