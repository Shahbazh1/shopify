module Collections
  class CreateService
    def initialize(store, params)
      @store = store
      @params = params
    end

    def call
      collection = @store.collections.new(@params)

      if collection.save
        {
          success: true,
          collection: collection
        }
      else
        {
          success: false,
          collection: collection,
          errors: collection.errors.full_messages
        }
      end
    end
  end
end