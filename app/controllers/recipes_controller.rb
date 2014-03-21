class RecipesController < ApplicationController

  def index
    if user_signed_in? && !params[:search]
      return @recipes = User.find(params[:user_id]).recipes
    end
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
