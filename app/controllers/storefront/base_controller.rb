class Storefront::BaseController < ApplicationController
  include StorefrontStoreLoader
  include CartManager

  layout "storefront"

  helper_method :current_customer
end