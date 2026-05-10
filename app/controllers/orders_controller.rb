class OrdersController < ApplicationController

  def index
    @store = Store.find(params[:store_id])
    @orders = Order.includes(:customer)
                   .order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
  end

  def confirmation
    @order      = Order.find(params[:id])
    @order_items = @order.order_items.includes(:product, :product_variant)
  end

end