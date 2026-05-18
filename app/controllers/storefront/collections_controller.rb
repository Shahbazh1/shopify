class Storefront::CollectionsController < Storefront::BaseController
  before_action :set_collection, only: :show

  def show
    @products = @collection.products
  end

  private

  def set_collection
    @collection = @store.collections.find(params[:id])
  end
end