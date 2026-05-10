class OrdersController < ApplicationController
  before_action :set_store
  before_action :set_order, only: [:show, :edit, :update, :confirmation]

  def index
    @orders = @store.orders
                    .includes(:customer)
                    .order(created_at: :desc)
  end

  def show
    @order_items = @order.order_items.includes(
      :product,
      :product_variant
    )
  end

  def confirmation
    @order_items = @order.order_items.includes(
      :product,
      :product_variant
    )
  end

  # EDIT PAGE
  def edit
  end

  # UPDATE STATUS
  def update
    if @order.update(order_params)
      redirect_to order_path(@store, @order),
                  notice: "Order updated successfully."
    else
      render :edit
    end
  end

  private

  def set_store
    @store = Store.find_by(id: params[:store_id])
  end

  def set_order
    @order = @store.orders.find_by(id:params[:id])
  end

  def order_params
    params.require(:order).permit(:status)
  end
end