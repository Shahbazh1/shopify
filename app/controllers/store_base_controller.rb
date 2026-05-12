class StoreBaseController < ApplicationController
  before_action :authenticate_user!
  before_action :set_store

  private

  def set_store
    @store = Store.find(params[:store_id])
  end
end