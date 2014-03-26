TestRailsOnDigitalOcean::Application.routes.draw do
  devise_for :users

  resources :users do
    get '/recipes', to: 'user_recipes#index'
    resources :recipes, only: [:show, :index, :create]
    resources :collected_recipes, only: [:show, :index, :create, :destroy, :update]
    resources :grocerylists, only: [:show, :create, :destroy]
    resources :scheduled_recipes, only: [:index, :destroy]
    post '/scheduled_recipes/:recipe_id', to: 'scheduled_recipes#create'
  end

  resources :recipes, only: [:show, :index]
  # post '/users/:user_id/collected_recipes/:recipe_id/add', to: 'collected_recipes#create'
  # post '/users/:user_id/collected_recipes/:recipe_id/remove', to: 'collected_recipes#destroy'

  root 'welcome#index'
end

