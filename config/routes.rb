Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

    root "welcome#index"


  # Health check stays outside the scope for monitoring tools
  get "up" => "rails/health#show", as: :rails_health_check
  post "/check_email", to: "auth_checks#check_email"

  # Everything inside this scope will be prefixed with /stores/:store_id
  scope '/stores/:store_id' do
    get "/home", to: "home#index", as: :store_home
    
    resources :orders
    resources :draft_orders
    resources :checkouts
    resources :collections
    resources :customers
    resources :products
    resources :product_variants
    resources :segments, only: [:index, :show]
    resources :inventories, only: [:index, :show, :edit]
    resources :discounts
  end

  # Keep the store management routes top-level if you need to create/list stores
  resources :stores
  
end