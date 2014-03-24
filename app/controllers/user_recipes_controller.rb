class UserRecipesController < ApplicationController
  def index
    if current_user
      user = User.find(params[:user_id])
      @recipes = user.recipes
    else
      redirect_to '/'
    end
  end

  # CODE REVIEW: Why does this controller create a ScheduledRecipe?
  def create
    ScheduledRecipe.create(recipe_params)
    redirect_to "/users/#{current_user.id}/scheduled_recipes"
  end

  private
  def recipe_params
    params.permit(:day, :recipe_id, :user_id)
  end
end
