module Discounts
  class ListQuery
    def initialize(store)
      @store = store
    end

    def call
      @store.discounts
    end
  end
end