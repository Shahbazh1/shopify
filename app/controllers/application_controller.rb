class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  layout :layout_by_resource

  def layout_by_resource
  if devise_controller?
    "application"
  elsif controller_name == "stores"
    false
  elsif controller_path.start_with?("storefront/")
    "storefront"                    # ← add this
  elsif user_signed_in?
    "dashboard"
  else
    "application"
  end
end

  def after_sign_in_path_for(resource)
    if resource.admin?
    admin_root_path
  else
    stores_path
  end
  end

  def after_sign_out_path_for(resource_or_scope)
    sign_in_path
  end

end
