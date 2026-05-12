class OrdersController < StoreBaseController
  include StoreFinder

  before_action :set_order,
                only: [:show, :edit, :update, :confirmation]

  def index
    @orders = Orders::ListQuery.new(@store).call
  end

  def show
    load_order_items
  end

  def confirmation
    load_order_items
  end

  def edit
  end

  def update
    result = Orders::UpdateService.new(
      @order,
      order_params
    ).call

    @order = result[:order]

    if result[:success]
      redirect_to order_path(@store, @order),
                  notice: "Order updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def load_order_items
    @order_items = Orders::ItemsQuery.new(@order).call
  end

  def set_order
    @order = @store.orders.find_by(id: params[:id])
  end

  def order_params
    params.require(:order).permit(:status)
  end
end