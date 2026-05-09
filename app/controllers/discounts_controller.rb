class DiscountsController < ApplicationController
  def index
    @store = current_user.stores.find(params[:store_id])
    @discounts = @store.discounts
  end

  def new
    @store = current_user.stores.find(params[:store_id])
    @collections = @store.collections
    @products = @store.products

    @discount = Discount.new(discount_type: params[:discount_type])
  end

  def create
    @store = current_user.stores.find(params[:store_id])
    @discount = @store.discounts.new(discount_params)
    @collections= @store.collections
    @products = @store.products

    if @discount.save
      redirect_to discounts_path(@store), notice: "Discount created"
    else
      render :new
    end
  end

  private

  def discount_params
    params.require(:discount).permit(
      :discount_type,
      :discount_title,
      :discount_method,
      :code_type,
      :discount_code,
      :auto_generate_code,
      :value_type,
      :value,
      :customer_eligibility,
      :minimum_requirement_type,
      :minimum_purchase_amount,
      :minimum_quantity,
      :limit_one_per_customer,
      :start_date,
      :end_date,

      product_discounts_attributes: [:id, :product_id, :_destroy],
      collection_discounts_attributes: [:id, :collection_id, :_destroy]
    )
  end
end