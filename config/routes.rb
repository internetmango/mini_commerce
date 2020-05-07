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
      collection do
        get :search
      end
      member do
        get :reset_password
      end
    end

    resources :orders , only: [:index, :show, :edit, :update, :destroy] do
      collection do
        get :search
      end
    end
    resources :products do
      collection do
        get :search
      end
    end
    resources :address, only: [:show]
    resources :categories do
      collection do
        get :search
      end
    end
    resources :featured_products do
      collection do
        get :search
      end
    end
    resources :banner_items do
      collection do
        get :search
      end
    end

    # Settings
    namespace :settings do
      resources :admin_users, only: :index
      resources :tax_rates do
        collection do
          get :search
        end
      end
      resources :shipping_methods do
        collection do
          get :search
        end
      end
      resources :payment_methods do
        collection do
          get :search
        end
      end
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
        resources :wishlist_items
        resource :register
        resources :banner_items, only: [:index]
        post :login, to: 'sessions#create'
        delete :logout, to: 'sessions#destroy'

        
      end
  end
end
