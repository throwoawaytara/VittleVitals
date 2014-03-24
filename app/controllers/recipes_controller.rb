class RecipesController < ApplicationController
  def index
    @results = Yummly.search('lasagna')
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
  end
  # If no nutrition data is avaiable then do not load the nutrition section in the view
end
