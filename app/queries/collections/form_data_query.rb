module Collections
  class FormDataQuery
    def initialize(store)
      @store = store
    end

    def call
      {
        products: @store.products
      }
    end
  end
end