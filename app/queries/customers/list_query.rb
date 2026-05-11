module Customers
  class ListQuery
    def initialize(store)
      @store = store
    end

    def call
      @store.customers
    end
  end
end