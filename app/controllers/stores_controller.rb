class StoresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_store, only: [:edit, :update, :destroy, :preview]

  def index
    @stores = Stores::IndexQuery.new(current_user).call

    if @stores.empty?
      redirect_to new_store_path
    end
  end

  def new
    @store = current_user.stores.new
  end

  def create
    result = Stores::CreateService.new(current_user, store_params).call

    @store = result[:store]

    if result[:success]
      redirect_to stores_path, notice: "Store created successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    result = Stores::UpdateService.new(@store, store_params).call

    @store = result[:store]

    if result[:success]
      redirect_to stores_path, notice: "Store updated successfully"
    else
      render :edit
    end
  end

  def destroy
    Stores::DestroyService.new(@store).call
    redirect_to stores_path, notice: "Store deleted successfully."
  end

  def preview
    redirect_to root_url(subdomain: @store.slug),
                allow_other_host: true
  end

  private

  def set_store
    @store = current_user.stores.find_by!(id: params[:id])
  end

  def store_params
    params.require(:store).permit(:name)
  end
end