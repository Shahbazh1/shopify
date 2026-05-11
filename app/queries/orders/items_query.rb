module Orders
  class ItemsQuery
    def initialize(order)
      @order = order
    end

    def call
      @order.order_items.includes(
        :product,
        :product_variant
      )
    end
  end
end