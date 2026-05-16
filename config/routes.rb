# config/routes.rb
require_relative "../lib/tasks/storefront_subdomain_constraint"
require_relative "../lib/tasks/admin_constraint"

Rails.application.routes.draw do
  devise_for :customers,
  controllers: {
    registrations: "customers/registrations",
    sessions: "customers/sessions"
  }

    # Admin routes
  constraints AdminConstraint do
      namespace :admin do
        root "dashboard#index"
        resources :users, only: [:index, :show, :destroy] do
         resources :stores, only: [:show, :destroy]
        end
      end
  end

  # ── Storefront (subdomain-based) ─────────────────────────────────────────
  # Must come FIRST so subdomain requests are caught before anything else
  constraints StorefrontSubdomainConstraint do
    scope module: :storefront do
      root  "home#index",             as: :storefront_root
      get   "/products",              to: "products#index",      as: :storefront_products
      get   "/products/:slug",        to: "products#show",       as: :storefront_product
      get   "/collections/:id",       to: "collections#show",    as: :storefront_collection
      get   "/cart",                  to: "cart#show",           as: :storefront_cart
      post  "/cart/items",            to: "cart#add_item",       as: :storefront_cart_add
      delete "/cart/items/:id",       to: "cart#remove_item",    as: :storefront_cart_remove
      get   "/checkout",              to: "checkout#show",       as: :storefront_checkout
      post  "/checkout",              to: "checkout#create",     as: :storefront_checkout_create
      get   "/contact",               to: "pages#contact",       as: :storefront_contact
      get   "/about",                 to: "pages#about",         as: :storefront_about
      get "/orders/:id/confirmation", to: "orders#confirmation", as: :storefront_order_confirmation
      get  "/account/orders",     to: "orders#index",  as: :storefront_orders
      get  "/account/orders/:id", to: "orders#show",   as: :storefront_order

      # Stripe Checkout routes
      post "/checkout/stripe", to: "checkout#create_stripe_session", as: :storefront_checkout_stripe
      get  "/checkout/success",  to: "checkout#success",  as: :storefront_checkout_success
      get  "/checkout/cancel",   to: "checkout#cancel",   as: :storefront_checkout_cancel
      post "/webhooks/stripe",   to: "stripe_webhooks#create", as: :storefront_stripe_webhook
    end
  end

  # ── Auth ──────────────────────────────────────────────────────────────────
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  # ── Default Urls ─────────────────────────────────────────────────────
  root "welcome#index"

  get "up" => "rails/health#show", as: :rails_health_check
  post "/check_email", to: "auth_checks#check_email"

  # Store management (create, list, delete stores)
  resources :stores do
    member do
      get :preview   # "View Store" button → redirects to subdomain
    end
  end

  # Everything inside this scope is prefixed with /stores/:store_id
  scope "/stores/:store_id" do
    get "/home", to: "home#index", as: :store_home

    resources :draft_orders do
      member do
        post :send_invoice
      end
    end
    resources :orders
    resources :draft_orders
    resources :checkouts
    resources :collections
    resources :customers
    resources :products
    resources :product_variants
    resources :segments,    only: [:index, :show]
    resources :inventories, only: [:index, :show, :edit, :update]
    resources :discounts
    resources :themes, only: [:index, :show], as: :store_themes
    resources :memberships, only: [:create, :destroy], as: :store_memberships
    get    "/settings",         to: "stores/settings#show",           as: :store_settings
    patch  "/settings",         to: "stores/settings#update",         as: :update_store_settings    
  end
end