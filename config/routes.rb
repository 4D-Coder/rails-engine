Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :items, except: [:new, :edit, :update]
      resources :merchants, only: [:index, :show]
    end
  end
end
