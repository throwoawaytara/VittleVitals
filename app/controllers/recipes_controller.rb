class RecipesController < ApplicationController
  def index
    if params[:search]
      @recipes = Recipe.search(params[:search])
    else
      @recipes =  Recipe.all
    end
  end

  # work on where to create recipe objects

  def show
    @recipe = Recipe.find(params[:id])
    @ingredients = @recipe.ingredients
    @instructions_domain = @recipe.instruction_url_split
    @nutrition_info = @recipe.nutrition_informations
    @health_labels = @recipe.health_labels
  end


end
