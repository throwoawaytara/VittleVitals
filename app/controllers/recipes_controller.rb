class RecipesController < ApplicationController
  def index
    p params
    if params[:search]
      @recipes = Recipe.search(params[:search], params[:method])
    else
      @recipes =  Recipe.all
    end
  end

  def show
    @recipe = params
    # @recipe = Recipe.find(params[:id])
  end
end
