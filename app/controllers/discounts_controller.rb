class DiscountsController < StoreBaseController
  include StoreFinder

  def index
    @discounts = Discounts::ListQuery.new(@store).call
  end

  def new
    load_form_data
    @discount = Discount.new(discount_type: params[:discount_type])
    @discount_type = params[:discount_type]
  end

  def create
    load_form_data

    result = Discounts::CreateService.new(
      @store,
      discount_params
    ).call

    @discount = result[:discount]

    if result[:success]
      redirect_to discounts_path(@store),
                  notice: "Discount created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def load_form_data
    @collections = @store.collections
    @products = @store.products
  end

  def discount_params
    params.require(:discount).permit(
      :discount_type,
      :discount_title,
      :discount_method,
      :discount_code,
      :auto_generate_code,
      :value_type,
      :value,
      :limit_one_per_customer,
      :start_date,
      :end_date,
    )
  end
end