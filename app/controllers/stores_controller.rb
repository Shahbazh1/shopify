class StoresController < ApplicationController
  before_action :authenticate_user!

  def index
    @stores = current_user.stores
  end

  def new
    @store = current_user.stores.new
  end

  def create
    @store = current_user.stores.new(store_params)

    if @store.save
      redirect_to stores_path, notice: "Store created successfully"
    else
      render :new
    end
  end

  def edit
    @store = current_user.stores.find(params[:id])
  end

  def update
    @store = current_user.stores.find(params[:id])

    if @store.update(store_params)
      redirect_to stores_path, notice: "Store updated successfully"
    else
      render :edit
    end
  end

  private

  def store_params
    params.require(:store).permit(:name)
  end
end