class UserRecipesController < ApplicationController
  def index
    user = User.find(params[:user_id])
    @recipes = user.recipes
  end

  def create
    ScheduledRecipe.create(recipe_params)
    redirect_to '/'
  end

  private
  def recipe_params
    params.permit(:day, :recipe_id, :user_id)
  end
end
