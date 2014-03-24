class RecipesController < ApplicationController
  def index
    if params[:search]
      @recipes = Recipe.search(params[:search], params[:search_type])
    else
      @recipes =  Recipe.all
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @ingredients_qty_units = @recipe.collect_ingredients_quantities_units
    

    @nutrition_info = @recipe.nutrition_calc
    @loaded_ingredients = "if not all ingredients were returned with nutrition data, list the ones that weren't here"
  end
  # If no nutrition data is avaiable then do not load the nutrition section in the view
end
