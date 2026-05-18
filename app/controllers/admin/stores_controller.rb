class Admin::StoresController < Admin::BaseController
  before_action :set_user
  before_action :set_store, only: [:show, :destroy]

  def show
  end

  def destroy
    @store.destroy

    redirect_to admin_user_path(@user),
                notice: "Store deleted successfully."
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_store
    @store = @user.stores.find(params[:id])
  end
end