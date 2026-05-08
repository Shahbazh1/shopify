class ThemesController < ApplicationController
  def index
    @store = Store.find(params[:store_id])
  end

  def show
  end
end
