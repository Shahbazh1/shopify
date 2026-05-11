module DraftOrders
  class CreateService
    def initialize(store, params)
      @store = store
      @params = params
    end

    def call
      draft_order = @store.draft_orders.new(@params)

      if draft_order.save
        { success: true, draft_order: draft_order }
      else
        { success: false, draft_order: draft_order }
      end
    end
  end
end