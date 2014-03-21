class RecipesController < ApplicationController
  def index
    if params[:search]
      @recipes = Recipe.search(params[:search], params[:method])
    else
      @recipes =  Recipe.all
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
end

