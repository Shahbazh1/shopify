module Stores
  class CreateService
    def initialize(user, params)
      @user = user
      @params = params
    end

    def call
      store = @user.owned_stores.new(@params)

      if store.save

        Membership.create!(
          user: @user,
          store: store,
          role: "admin"
        )

        { success: true, store: store }
      else
        puts store.errors.full_messages

        { success: false, store: store }
      end
    end
  end
end