module Orders
  class UpdateService
    def initialize(order, params, user)
      @order = order
      @params = params
      @user = user
    end

    def call
      @order.updated_by_id = @user.id

      if @order.update(@params)
        {
          success: true,
          order: @order
        }
      else
        {
          success: false,
          order: @order,
          errors: @order.errors.full_messages
        }
      end
    end
  end
end