# app/controllers/storefront/base_controller.rb
class Storefront::BaseController < ApplicationController
  skip_before_action :authenticate_user!  # storefront is public
  before_action :set_store
  layout "storefront"

  private

  def set_store
    @store = Store.find_by!(slug: request.subdomain)
  rescue ActiveRecord::RecordNotFound
    render file: Rails.root.join("public/404.html"), 
           status: :not_found, 
           layout: false
  end
end