# app/controllers/admin/stores_controller.rb
class Admin::StoresController < Admin::BaseController
  def show
    @user  = User.find(params[:user_id])
    @store = @user.stores.find(params[:id])
  end

  def destroy
    @user  = User.find(params[:user_id])
    @store = @user.stores.find(params[:id])
    @store.destroy
    redirect_to admin_user_path(@user), notice: "Store deleted successfully."
  end
end