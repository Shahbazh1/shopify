Rails.application.routes.draw do
  get "dashboard/index"
  devise_for :users, controllers: {
  omniauth_callbacks: 'users/omniauth_callbacks'
}
  root "home#index"
  get "up" => "rails/health#show", as: :rails_health_check
  post "/check_email", to: "auth_checks#check_email"
  get "/dashboard", to: "dashboard#index", as: :dashboard

end
