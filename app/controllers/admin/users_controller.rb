# app/controllers/admin/users_controller.rb
class Admin::UsersController < Admin::BaseController
  def index
    @users = User.includes(:stores).order(created_at: :desc)
  end

  def show
    @user   = User.find(params[:id])
    @stores = @user.stores.includes(:orders)
  end

  def destroy
    @user = User.find(params[:id])

    if @user == current_user
      redirect_to admin_users_path, alert: "You cannot delete yourself."
      return
    end

    @user.destroy
    redirect_to admin_users_path, notice: "User deleted successfully."
  end
end