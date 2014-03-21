class WelcomeController < ApplicationController
  def index
    if params[:search]
      @recipes = Recipe.search(params[:search])
    else
      @recipes =  Recipe.all
    end
  end
end
