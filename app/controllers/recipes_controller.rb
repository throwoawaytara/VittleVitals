class RecipesController < ApplicationController
  def index
    if params[:search]
      @recipes = Recipe.search(params[:search], params[:search_type])
    else
      @recipes =  Recipe.all
    end
  end

  # work on where to create recipe objects

  def show
    @recipe = Recipe.find(params[:id])
    @nutrition_info = @recipe.nutrition_calc
    @loaded_ingredients = "if not all ingredients were returned with nutrition data, list the ones that weren't here"
    @ingredients_qty_units = @recipe.collect_ingredients_quantities_units

    @nutrition_info = @recipe.nutrition[:stats]
     # we still need a method to determine whether we have the ingredient or not,
     # so at this point @unloaded_ingredients is pointless because i'm just shoving everything
     # in it right now to make sure the shoveling only pushed the ingredient name in once
    @unloaded_ingredients = @recipe.nutrition[:unloaded]
    @ingredient_units = @recipe.nutrition[:ingredient_units]
  end
  # If no nutrition data is avaiable then do not load the nutrition section in the view

  def cache_database(query)
    recipe = get_recipe_from_yummly(query)
    recipe_id = recipe.matches.first["id"]
    ingredients_arr = recipe.matches.first["ingredients"]
    recipe_details = get_details_from_yummly(recipe_id)
    serving_size = recipe_details.json['numberOfServings']
    # Recipe.create
  end

  def get_recipe_from_yummly(query)
    Yummly.search(query, {max: 1})
  end

  def get_details_from_yummly(recipe_id)
    Yummly.find(recipe_id)
  end
end
