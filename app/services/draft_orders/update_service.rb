module DraftOrders
  class UpdateService
    def initialize(draft_order, params)
      @draft_order = draft_order
      @params = params
    end

    def call
      if @draft_order.update(@params)
        { success: true, draft_order: @draft_order }
      else
        { success: false, draft_order: @draft_order }
      end
    end
  end
end