class DiscountsController < ApplicationController
  def index
      @store = current_user.stores.find(params[:store_id])

    @discounts = @store.discounts
  end

  def new
    @discount = Discount.new
  end

  def create
  @store = current_user.stores.find(params[:store_id])
  @discount = @store.discounts.new(discount_params)

  if @discount.save
    redirect_to discounts_path, notice: "Discount created"
  else
    render :new
  end
end

  private

  def discount_params
    params.require(:discount).permit(
      :discount_type,
      :discount_method,
      :code_type,
      :discount_code,
      :auto_generate_code,

      :value_type,        # percentage or fixed
      :value,             # discount value

      :applies_to,       # specific collections / products

      :customer_eligibility, # all customers etc

      :minimum_requirement_type,  # none / amount / quantity
      :minimum_purchase_amount,
      :minimum_quantity,

      :max_usage_limit,
      :limit_one_per_customer,

      :product_discount,
      :order_discount,
      :shipping_discount,

      :start_date,
      :end_date
    )
  end
end