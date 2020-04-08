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

  namespace :admin do
    resource :dashboard, only: :show
    resource :users do
      collection do
        get 'all'
        get 'reset_password'
      end
    end
    resource :orders , only: [:show,:edit,:update] do
      collection do
        get 'all'
      end
    end
  end
end
