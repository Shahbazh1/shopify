module Collections
  class UpdateService
    def initialize(collection, params)
      @collection = collection
      @params = params
    end

    def call
      ActiveRecord::Base.transaction do
        @collection.product_collections.destroy_all

        if @collection.update(@params)
          {
            success: true,
            collection: @collection
          }
        else
          raise ActiveRecord::Rollback
        end
      end

      if @collection.errors.empty?
        {
          success: true,
          collection: @collection
        }
      else
        {
          success: false,
          collection: @collection,
          errors: @collection.errors.full_messages
        }
      end
    end
  end
end