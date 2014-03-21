class UserRecipesController < ApplicationController
  def index
    user = User.find(params[:user_id])
    @user_recipes = user.recipes
  end
end
