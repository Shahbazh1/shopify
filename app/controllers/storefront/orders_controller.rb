# app/controllers/storefront/orders_controller.rb
class Storefront::OrdersController < Storefront::BaseController
  helper OrdersHelper
  before_action :authenticate_customer!

  def index
    @orders = current_customer.orders
                              .where(store: @store)
                              .order(created_at: :desc)
  end

  def show
    @order = current_customer.orders
                             .where(store: @store)
                             .find(params[:id])
  end
end