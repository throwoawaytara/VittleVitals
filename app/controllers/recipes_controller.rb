class RecipesController < ApplicationController

  def index
    if user_signed_in?
      @recipes = User.find(params[:user_id]).recipes
    end
    elsif params[:search]
      @recipes = Recipe.search(params[:search], params[:method])
    else
      @recipes =  Recipe.all
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
end
