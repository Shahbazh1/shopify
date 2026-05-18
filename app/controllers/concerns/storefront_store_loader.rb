module StorefrontStoreLoader
  extend ActiveSupport::Concern

  included do
    before_action :set_store
  end

  private

  def set_store
    @store = Store.find_by!(slug: request.subdomain)
  rescue ActiveRecord::RecordNotFound
    render file: Rails.root.join("public/404.html"),
           status: :not_found,
           layout: false
  end
end