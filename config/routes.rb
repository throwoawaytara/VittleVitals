TestRailsOnDigitalOcean::Application.routes.draw do
  devise_for :users

  resources :users do
    get '/recipes', to: 'user_recipes#index'
    resources :recipes, only: [:show]
    resources :collected_recipes, only: [:create]
    resources :grocerylists, only: [:show, :create, :destroy]
    resources :scheduled_recipes, only: [:index, :destroy]
    post '/scheduled_recipes/:recipe_id', to: 'scheduled_recipes#create'
  end

  resources :recipes, only: [:show, :index]

  root 'welcome#index'
end

