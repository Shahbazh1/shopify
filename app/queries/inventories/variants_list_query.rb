module Inventories
  class VariantsListQuery
    def initialize(store)
      @store = store
    end

    def call
      ProductVariant
        .includes(:product)
        .where(products: { store_id: @store.id })
        .references(:product)
    end
  end
end