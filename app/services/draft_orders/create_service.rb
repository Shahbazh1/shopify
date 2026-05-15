module DraftOrders
  class CreateService
    def initialize(store, params, user: nil)
      @store = store
      @params = params
      @user   = user
    end

    def call
      draft_order = @store.draft_orders.new(@params)
      draft_order.user_id = @user.id if @user

      ActiveRecord::Base.transaction do

        if draft_order.save

          # decrease stock
          draft_order.draft_order_items.each do |item|

            variant = item.product_variant

            next unless variant

            # prevent negative stock
            if variant.stock_quantity >= item.quantity

              variant.stock_quantity -= item.quantity

              variant.save!

            else
              current_stock = variant.stock_quantity.to_i
              draft_order.errors.add(
                :base,
                "Only #{current_stock} items available for #{variant.size} / #{variant.color}"
              )

             raise ActiveRecord::Rollback
            end
          end

          return {
            success: true,
            draft_order: draft_order
          }

        else
          raise ActiveRecord::Rollback
        end
      end

      {
        success: false,
        draft_order: draft_order
      }
    end
  end
end