module DraftOrders
  class ListQuery
    def initialize(store)
      @store = store
    end

    def call
      @store.draft_orders.order(created_at: :desc)
    end
  end
end