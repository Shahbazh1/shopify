class CollectionsController < ApplicationController

  def index
    @store = current_user.stores.find(params[:store_id])
    @collections = @store.collections
  end

  def show
    @store = current_user.stores.find(params[:store_id])
    @collection = @store.collections.find(params[:id])
  end

  def new
    @store = current_user.stores.find(params[:store_id])
    @collection = @store.collections.new
    @products = @store.products
  end

  def create
    @store = current_user.stores.find(params[:store_id])
    @collection = @store.collections.new(collection_params)

    if @collection.save
      redirect_to collections_path(store_id: @store.id), notice: "Collection created successfully"
    else
      @products = @store.products
      render :new
    end
  end

  def edit
    @store = current_user.stores.find(params[:store_id])
    @collection = @store.collections.find(params[:id])
  end

  def update
    @store = current_user.stores.find(params[:store_id])
    @collection = @store.collections.find(params[:id])

    if @collection.update(collection_params)
      redirect_to store_collections_path(@store), notice: "Collection updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @store = current_user.stores.find(params[:store_id])
    @collection = @store.collections.find(params[:id])
    @collection.destroy

    redirect_to store_collections_path(@store), notice: "Collection deleted"
  end

  private

  def collection_params
  params.require(:collection).permit(
    :title,
    :description,
    product_collections_attributes: [:id, :product_id, :_destroy]
  )
end
end