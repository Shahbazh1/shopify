# app/controllers/storefront/orders_controller.rb
class Storefront::OrdersController < Storefront::BaseController
  def confirmation
    @order      = Order.find(params[:id])
    @order_items = @order.order_items.includes(:product, :product_variant)
  end
end