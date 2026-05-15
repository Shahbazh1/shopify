module Memberships
  class CreateService
    def initialize(store:, email:)
      @store = store
      @email = email
      @errors = []
    end

    attr_reader :errors, :membership

    def call
      user = find_user

      return error("No user found with that email.") if user.nil?
      return error("User is already a member.") if already_member?(user)

      @membership = create_membership(user)

      success
    end

    def success?
      errors.empty?
    end

    private

    attr_reader :store, :email

    def find_user
      Memberships::FindUserByEmail.new(email).call
    end

    def already_member?(user)
      store.memberships.exists?(user: user)
    end

    def create_membership(user)
      Membership.create!(user: user, store: store, role: "member")
    end

    def error(message)
      errors << message
      false
    end

    def success
      true
    end
  end
end