class UserRecipesController < ApplicationController
  def index
    user = User.find(params[:user_id])
    @user_recipes = user.recipes
  end

  def create
    ScheduledRecipe.create(recipe_params)
    redirect_to '/'
  end

  private
  def recipe_params
    params.require(:scheduled_recipe).permit(:day, :recipe_id, :user_id)
  end
end
