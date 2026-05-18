class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[show destroy]
  before_action :prevent_self_deletion, only: :destroy

  def index
    @users = User.includes(:stores)
                 .order(created_at: :desc)
  end

  def show
    @stores = @user.stores.includes(:orders)
  end

  def destroy
    @user.destroy

    redirect_to admin_users_path,
                notice: "User deleted successfully."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def prevent_self_deletion
    return unless @user == current_user

    redirect_to admin_users_path,
                alert: "You cannot delete yourself."
  end
end