class CustomersController < ApplicationController
  def index
    @store= Store.first
    @customers = @store.customers
  end

  def create
    @store = Store.first
    @customer = @store.customers.new(customer_params)
 
    if @customer.save
      redirect_to @customer, notice: "Customer was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @store = Store.first
    @customer = @store.customers.new
  end
 
  def show
    @store = Store.first
    @customer = @store.customers.find(params[:id])
  end
 
  # … edit / update / destroy etc.
 
  private
 
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
