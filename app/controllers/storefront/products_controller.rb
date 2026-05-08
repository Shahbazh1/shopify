# app/controllers/storefront/products_controller.rb
class Storefront::ProductsController < Storefront::BaseController
  def index
    @products = @store.products
                      .where(published_online_store: true)
  end

  def show
    @product  = @store.products.find_by!(slug: params[:slug])
    @variants = @product.product_variants
    @images   = @product.product_images
  rescue ActiveRecord::RecordNotFound
    render file: Rails.root.join("public/404.html"),
           status: :not_found,
           layout: false
  end
end