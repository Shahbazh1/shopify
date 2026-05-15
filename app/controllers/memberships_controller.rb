# app/controllers/memberships_controller.rb
class MembershipsController < StoreBaseController
  before_action :authenticate_user!
  before_action :set_store
  before_action :authorize_store_management!

  def create
  service = Memberships::CreateService.new(
    store: @store,
    email: membership_params[:email]
  )

  service.call

  if service.success?
    flash.now[:notice] = "#{membership_params[:email]} added as member."
  else
    flash.now[:alert] = service.errors.first
  end

  @memberships = @store.memberships.includes(:user)
  @new_membership = Membership.new

  render "stores/settings/show", status: :unprocessable_entity
end

  def destroy
  membership = @store.memberships.find(params[:id])

  if membership.user == current_user
    redirect_to store_settings_path(@store), alert: "You can't remove yourself."
    return
  end

  membership.destroy
  redirect_to store_settings_path(@store), notice: "Member removed."
end

  private

  def authorize_store_management!
    authorize @store, :manage_members?
  end

  def set_store
    @store = current_user.stores.find_by!(id: params[:store_id])
  end

  def membership_params
    params.require(:membership).permit(:email)
  end
end