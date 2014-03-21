class WelcomeController < ApplicationController
  def index
    if params[:search]
      @recipes = Recipe.search(params[:search])
    end
  end
end