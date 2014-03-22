TestRailsOnDigitalOcean::Application.routes.draw do
  devise_for :users

  resources :users do
    get '/recipes', to: 'user_recipes#index'
    post '/recipe/:recipe_id', to: 'user_recipes#create'
    resources :recipes, only: [:show]
    resources :collected_recipes, only: [:create]
    resources :grocerylists, only: [:show]
    resources :scheduled_recipes
  end

  resources :ingredient
  resources :recipes, only: [:show, :index]

  root 'welcome#index'

end
