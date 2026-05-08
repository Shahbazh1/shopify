# app/controllers/storefront/home_controller.rb
class Storefront::HomeController < Storefront::BaseController
  def index
    @products    = @store.products
                         .where(published_online_store: true)
                         .limit(12)
    @collections = @store.collections
  end
end