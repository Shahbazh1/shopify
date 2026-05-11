module Orders
  class ListQuery
    def initialize(store)
      @store = store
    end

    def call
      @store.orders
            .includes(:customer)
            .order(created_at: :desc)
    end
  end
end