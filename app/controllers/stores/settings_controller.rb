# app/controllers/stores/settings_controller.rb
class Stores::SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_store

  def show
    @memberships = @store.memberships.includes(:user)
    @new_membership = Membership.new
  end

  def update
    authorize @store
    if @store.update(store_params)
      redirect_to store_settings_path(@store), notice: "Store name updated."
    else
      @memberships = @store.memberships.includes(:user)
      @new_membership = Membership.new
      render :show, status: :unprocessable_entity
    end
  end

  private

  def set_store
    @store = current_user.stores.find_by!(id: params[:store_id])
  end

  def store_params
    params.require(:store).permit(:name)
  end
end