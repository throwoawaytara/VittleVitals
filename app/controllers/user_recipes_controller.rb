class UserRecipesController < ApplicationController
  def index
    user = User.find(params[:user_id])
    @user_recipes = user.recipes
  end

  def create
    puts '=============================== STRONG PARAMS ==============================='
    p recipe_params
    ScheduledRecipe.create(day: params[:day],
                           recipe_id: params[:recipe_id],
                           user_id: current_user.id)
    redirect_to '/'
  end

  # private
  # def recipe_params
  #   params.require(:user_id).permit(:day, :recipe_id) # need a recipe_id
  # end
end
