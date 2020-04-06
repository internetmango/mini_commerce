Rails.application.routes.draw do
  devise_for :users
  root to: 'mockups#index'
  resources :mockups, only: :index do
    collection do
      get :search
      get :category
      get :cart
    end
  end
end
