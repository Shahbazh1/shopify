# class Users::OmniauthCallbacksController < ApplicationController
# end

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2 
    handle_auth "Google"
  end

  def facebook
    handle_auth "Facebook"
  end

  private

  def handle_auth(kind)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user
    else
      redirect_to new_user_registration_path, alert: "Error signing in with #{kind}"
    end
  end
end