class UserRecipesController < ApplicationController
  def index
    user = User.find(params[:user_id])
    @recipes = user.recipes
  end
end
