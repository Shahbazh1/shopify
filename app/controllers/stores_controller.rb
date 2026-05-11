class StoresController < ApplicationController
  include StoreFinder

  before_action :authenticate_user!

  def index
    @stores = current_user.stores

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
      redirect_to stores_path,
                  notice: "Store created successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @store.update(store_params)
      redirect_to stores_path,
                  notice: "Store updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @store.destroy
    redirect_to stores_path,
                notice: "Store deleted successfully."
  end

  def preview
    redirect_to root_url(subdomain: @store.slug),
                allow_other_host: true
  end

  private

  def store_params
    params.require(:store).permit(:name)
  end
end