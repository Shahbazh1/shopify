class Storefront::ProductsController < Storefront::BaseController
  before_action :set_product, only: :show

  def index
    @products = published_products
  end

  def show
    @variants = @product.product_variants
    @images   = @product.product_images
  end

  private

  def published_products
    @store.products.where(published_online_store: true)
  end

  def set_product
    @product = @store.products.find_by!(slug: params[:slug])
  end
end