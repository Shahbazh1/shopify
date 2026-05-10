class CheckoutsController < ApplicationController
  before_action :set_store

  def index
    @cartItem = CartItem.all
    @carts = @store.carts.includes(:customer, cart_items: [:product, :product_variant])
  end

  def show
    @cart = @store.carts.includes(cart_items: [:product, :product_variant]).find(params[:id])
  end

  private

  def set_store
    @store = Store.find(params[:store_id])
  end
end