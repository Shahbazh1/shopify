class Admin::DashboardController < Admin::BaseController
  def index
    @users       = User.includes(:stores).order(created_at: :desc)
    @total_users  = User.count
    @total_stores = Store.count
    @total_orders = Order.count
    @admins       = User.where(role: "admin").count
  end
end