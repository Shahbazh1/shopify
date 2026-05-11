module Collections
  class ListQuery
    def initialize(store)
      @store = store
    end

    def call
      @store.collections
    end
  end
end