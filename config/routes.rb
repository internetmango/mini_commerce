Rails.application.routes.draw do
  root to: 'mockups#index'
  resources :mockups, only: :index do
    collection do
      get :search
      get :category
      get :cart
    end
  end
end
