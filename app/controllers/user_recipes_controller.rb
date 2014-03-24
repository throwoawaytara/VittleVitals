class UserRecipesController < ApplicationController
  def index
    if current_user
      user = User.find(params[:user_id])
      @recipes = user.recipes
    else
      redirect_to '/'
    end
  end
end
