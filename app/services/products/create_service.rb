module Products
  class CreateService
    def initialize(store, params)
      @store = store
      @params = params
    end

    def call
      product = @store.products.new(@params)

      if product.save
        {
          success: true,
          product: product
        }
      else
        {
          success: false,
          product: product,
          errors: product.errors.full_messages
        }
      end
    end
  end
end