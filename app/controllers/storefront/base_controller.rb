class Storefront::BaseController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  include StorefrontStoreLoader
  include CartManager

  layout "storefront"

  helper_method :current_customer

  private

  def render_not_found
    render file: Rails.root.join("public/404.html"),
           status: :not_found,
           layout: false
  end
end