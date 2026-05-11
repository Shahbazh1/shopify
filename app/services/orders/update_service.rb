module Orders
  class UpdateService
    def initialize(order, params)
      @order = order
      @params = params
    end

    def call
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