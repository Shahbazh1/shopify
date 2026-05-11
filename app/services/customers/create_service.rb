module Customers
  class CreateService
    def initialize(store, params)
      @store = store
      @params = params
    end

    def call
      customer = @store.customers.new(@params)

      if customer.save
        {
          success: true,
          customer: customer
        }
      else
        {
          success: false,
          customer: customer,
          errors: customer.errors.full_messages
        }
      end
    end
  end
end