TestRailsOnDigitalOcean::Application.routes.draw do
  devise_for :users

  resources :users do
    # CODE REVIEW: Everything with the word recipe here can be done in the
    # recipes controller (with some changes).
    # See also: http://guides.rubyonrails.org/routing.html#adding-more-restful-actions
    get '/recipes', to: 'user_recipes#index'
    post '/recipe/:recipe_id', to: 'user_recipes#create'
    resources :recipes, only: [:show]
    resources :collected_recipes, only: [:create]
    resources :grocerylists, only: [:show, :create, :destroy]
    resources :scheduled_recipes, only: [:index, :destroy]
  end

  resources :recipes, only: [:show, :index]

  root 'welcome#index'
end

