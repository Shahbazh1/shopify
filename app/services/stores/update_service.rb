module Stores
  class CreateService
    def initialize(user, params)
      @user = user
      @params = params
    end

    def call
      store = @user.stores.new(@params)

      if store.save
        { success: true, store: store }
      else
        { success: false, store: store }
      end
    end
  end
end