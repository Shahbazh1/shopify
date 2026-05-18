module DraftOrders
  class UpdateService
    def initialize(draft_order, params, user: nil)
      @draft_order = draft_order
      @params = params
      @user = user
    end

    def call
      @draft_order.user_id = @user.id if @user

      if @draft_order.update(@params)
        { success: true, draft_order: @draft_order }
      else
        { success: false, draft_order: @draft_order }
      end
    end
  end
end