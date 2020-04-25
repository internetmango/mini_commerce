# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path: 'auth',
                     path_names: { sign_in: 'login', sign_out: 'logout',
                                   registration: 'register', sign_up: 'signup' }
  root to: 'pages#index'

  resources :mockups, only: :index do
    collection do
      get :search
      get :category
      get :cart
    end
  end

  # Admin
  namespace :admin do
    resource :dashboard, only: :show
    resources :users do
      member do
        get :reset_password
      end
    end

    resources :orders , only: [:index, :show, :edit, :update, :destroy]
    resources :products do
      collection do
        get :search
      end
    end
    resources :address, only: [:show]
    resources :categories
    resources :featured_products

    # Settings
    namespace :settings do
      resources :admin_users, only: :index
      resources :tax_rates
      resources :shipping_methods
      resources :payment_methods
    end
  end

  # Api
  namespace :api do
      namespace :v1 do
        resources :products,except: [:new] do
          collection do
            get :search
          end
        end
        resources :users, except: [:new, :edit] do
          member do
            get :reset_password
          end
          resources :addresses
        end
        resources :orders, only: [:index, :show, :update]
        resource :cart do
          member do
            post :add_item
            post :finalize
          end
        end
        resource :account
        resources :categories, except: [:new, :edit]
        resources :product_stocks, only: [:index, :show, :update]
        resources :product_images, except: [:new, :edit]
        resources :featured_products, only: [:index]
      end
  end
end
