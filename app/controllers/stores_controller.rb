class StoresController < ApplicationController
  before_action :authenticate_user!

  def index
  # Change @store to @stores and fetch all stores for the user
  @stores = current_user.stores 

  # If you still want to redirect if they have NO stores at all:
  if @stores.empty?
    redirect_to new_store_path
  end
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
    @store = current_user.stores.find_by!(id: params[:store_id])
  end

  def update
    @store = current_user.stores.find_by!(id: params[:store_id])

    if @store.update(store_params)
      redirect_to stores_path, notice: "Store updated successfully"
    else
      render :edit
    end
  end

  def destroy
  @store = Store.find(params[:id])
  @store.destroy

  redirect_to stores_path, notice: "Store deleted successfully."
end

  private

  def store_params
    params.require(:store).permit(:name)
  end
end