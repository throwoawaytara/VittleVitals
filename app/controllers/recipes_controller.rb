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

    @nutrition_info = @recipe.nutrition[:stats]
     # we still need a method to determine whether we have the ingredient or not,
     # so at this point @unloaded_ingredients is pointless because i'm just shoving everything
     # in it right now to make sure the shoveling only pushed the ingredient name in once
    @unloaded_ingredients = @recipe.nutrition[:unloaded]
    @ingredient_units = @recipe.nutrition[:ingredient_units]
    
  end
  # If no nutrition data is avaiable then do not load the nutrition section in the view
end
