class AuthChecksController < ApplicationController
  def check_email
    email = params[:email].to_s.strip.downcase

    # CASE 1: No email provided (navbar button click)
    if email.blank?
      redirect_to new_user_registration_path
      return
    end

    # CASE 2: Email provided → check user
    user = User.find_by(email: email)

    if user
      redirect_to new_user_session_path(email: email)
    else
      redirect_to new_user_registration_path(email: email)
    end
  end
end