module Memberships
  class FindUserByEmail
    def initialize(email)
      @email = email
    end

    def call
      User.find_by(email: email)
    end

    private

    attr_reader :email
  end
end