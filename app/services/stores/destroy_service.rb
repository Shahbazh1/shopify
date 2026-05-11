module Stores
  class DestroyService
    def initialize(store)
      @store = store
    end

    def call
      @store.destroy
      { success: true }
    end
  end
end