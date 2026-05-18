class Storefront::HomeController < Storefront::BaseController
  def index
    @products    = published_products
    @collections = @store.collections
  end

  private

  def published_products
    @store.products.where(published_online_store: true)
  end
end