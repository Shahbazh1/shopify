module Stores
  class IndexQuery
    def initialize(user)
      @user = user
    end

    def call
      @user.stores
    end
  end
end