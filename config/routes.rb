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
    resources :products
    resources :address, only: [:show]

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
        resources :products,except: [:new]
        resources :users, except: [:new, :edit] do
          member do
            get :reset_password
          end
          resources :addresses
        end
        resources :orders, only: [:index, :show, :update]
        resources :carts do
          collection do
            post :add_cart
            get :cart
            patch :update
            get :finalize
            delete :remove
          end
        end
        resources :categories, except: [:new, :edit]
        resources :product_stocks, only: [:index, :show, :update]
        resources :product_images, except: [:new, :edit]
      end
  end
end
