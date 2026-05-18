class Storefront::OrdersController < Storefront::BaseController
  before_action :authenticate_customer!
  before_action :set_order, only: :show

  def index
    @orders = scoped_orders.order(created_at: :desc)
  end

  def show; end

  private

  def set_order
    @order = scoped_orders.find(params[:id])
  end

  def scoped_orders
    current_customer.orders.where(store: @store)
  end
end