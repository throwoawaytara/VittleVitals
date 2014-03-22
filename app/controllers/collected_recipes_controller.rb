class CollectedRecipesController < ActionController::Base
  def create
    current_user.recipes << Recipe.find(params[:recipe])
    redirect_to root_url
  end
end
