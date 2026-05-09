# app/controllers/storefront/home_controller.rb
class Storefront::HomeController < Storefront::BaseController
  def index
    @products    = @store.products

    @collections = @store.collections
  end
end