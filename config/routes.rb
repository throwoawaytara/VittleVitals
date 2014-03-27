TestRailsOnDigitalOcean::Application.routes.draw do
  devise_for :users

  resources :users do
    get '/recipes', to: 'user_recipes#index'
    resources :recipes, only: [:show, :index, :create, :destroy]
    resources :collected_recipes, only: [:show, :create, :destroy]
    resources :grocerylists, only: [:show, :create, :destroy]
    resources :scheduled_recipes, only: [:index, :destroy]
    post '/scheduled_recipes/:recipe_id', to: 'scheduled_recipes#create'
  end

  post '/users/:user_id/collected_recipes/:id/destroy', to: 'user_collected_recipes#destroy'

  get 'twilio/text' => 'twilio#text'

  resources :collected_recipes, only: [:destroy, :create]



  resources :recipes, only: [:show, :index]

  root 'welcome#index'
end

