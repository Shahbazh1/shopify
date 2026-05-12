class CustomersController < StoreBaseController
  include StoreFinder

  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    @customers = Customers::ListQuery.new(@store).call
  end

  def show
  end

  def new
    @customer = @store.customers.new
  end

  def create
    result = Customers::CreateService.new(
      @store,
      customer_params
    ).call

    @customer = result[:customer]

    if result[:success]
      redirect_to customer_path(@store, @customer),
                  notice: "Customer was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to customer_path(@store, @customer),
                  notice: "Customer updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @customer.destroy
    redirect_to store_customers_path(@store),
                notice: "Customer deleted"
  end

  private

  def set_customer
    @customer = @store.customers.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(
      :first_name,
      :last_name,
      :email,
      :phone,
      :language,
      :address,
      :apartment,
      :city,
      :company,
      :country,
      :postal_code,
      :is_default
    )
  end
end