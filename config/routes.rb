Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v0 do
      resources :customer_subscriptions, only: [:index, :create, :destroy]
      resources :customers, only: [:show]
    end
  end
end
