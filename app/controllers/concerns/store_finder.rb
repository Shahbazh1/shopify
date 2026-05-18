module StoreFinder
  extend ActiveSupport::Concern

  included do
    before_action :set_user_store
  end

  private

  def set_user_store
    @store = current_user.stores.find_by(id: params[:store_id])

    unless @store
      redirect_to root_path, alert: "Store not found"
    end
  end
end