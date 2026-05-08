# app/controllers/storefront/collections_controller.rb
class Storefront::CollectionsController < Storefront::BaseController
  def show
    @collection = @store.collections.find(params[:id])
    @products   = @collection.products
                             .where(published_online_store: true)
  rescue ActiveRecord::RecordNotFound
    render file: Rails.root.join("public/404.html"),
           status: :not_found,
           layout: false
  end
end