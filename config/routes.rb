Rails.application.routes.draw do
  get "checkouts/index"
  get "draft_orders/index"
  devise_for :users, controllers: {
  omniauth_callbacks: 'users/omniauth_callbacks'
}
  root "welcome#index"
  get "up" => "rails/health#show", as: :rails_health_check
  post "/check_email", to: "auth_checks#check_email"
  get "/home", to: "home#index", as: :home
  resources :orders
  resources :draft_orders
  resources :checkouts

end
