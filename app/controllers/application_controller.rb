class ApplicationController < ActionController::Base
  include Pundit::Authorization
  layout :layout_by_resource
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
    redirect_to root_path, alert: "You are not authorized to access this store."
  end

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

 def user_not_authorized
    render plain: "You are not authorized to perform this action.",
           status: :forbidden
  end

  def after_sign_in_path_for(resource)
  case resource
  when User
    if  resource.super_admin?
      admin_root_path
    else
      stores_path
    end

  when Customer
    storefront_root_path
  else
    root_path
  end
end

  def after_sign_out_path_for(resource_or_scope)
    sign_in_path
  end

end
