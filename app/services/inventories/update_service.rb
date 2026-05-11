module Inventories
  class UpdateService
    def initialize(variant, params)
      @variant = variant
      @params = params
    end

    def call
      if @variant.update(@params)
        {
          success: true,
          variant: @variant
        }
      else
        {
          success: false,
          variant: @variant,
          errors: @variant.errors.full_messages
        }
      end
    end
  end
end