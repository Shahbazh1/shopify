module DraftOrders
  class FormDataQuery
    def initialize(store, draft_order = nil)
      @store = store
      @draft_order = draft_order
    end

    def products
      @store.products.includes(:product_variants)
    end

    def items
      return [] unless @draft_order

      @draft_order.draft_order_items.includes(:product, :product_variant)
    end
  end
end