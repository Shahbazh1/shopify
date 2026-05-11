module Discounts
  class CreateService
    def initialize(store, params)
      @store = store
      @params = params
    end

    def call
      discount = @store.discounts.new(@params)

      if discount.save
        {
          success: true,
          discount: discount
        }
      else
        {
          success: false,
          discount: discount,
          errors: discount.errors.full_messages
        }
      end
    end
  end
end