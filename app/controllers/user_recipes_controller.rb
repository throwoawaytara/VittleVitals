class UserRecipesController < ApplicationController
  def index
    user = User.find(params[:user_id])
    @user_recipes = user.recipes
  end

  def create
    ScheduledRecipe.create(recipe_params)
  end

  private
  def recipe_params
    params.require(:recipe).permit(:day) # need a recipe_id ?
  end
end
