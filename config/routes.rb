Rails.application.routes.draw do
  devise_for :users, controllers: {
  omniauth_callbacks: 'users/omniauth_callbacks'
}
  root "welcome#index"
  get "up" => "rails/health#show", as: :rails_health_check
  post "/check_email", to: "auth_checks#check_email"
  get "/home", to: "home#index", as: :home
  resources :stores
  resources :orders
  resources :draft_orders
  resources :checkouts
  resources :collections
  resources :customers
  resources :products
  resources :product_variants
  resources :segments, only: [:index, :show]
  resources :inventories, only: [:index, :show, :edit]
end
