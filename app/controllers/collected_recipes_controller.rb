class CollectedRecipesController < ActionController::Base
  def create
    # CODE REVIEW: I'm not following what is happening here. What's the
    # difference between user.recipes and user.collected_recipes and
    # user.collected_recipes that have been favorited?
    if params[:favorite]
      if current_user.recipes.exists?(params[:recipe])
        collected = current_user.collected_recipes.where(recipe_id: params[:recipe]).first
        collected.favorite = params[:favorite]
        collected.save
      else
        CollectedRecipe.create(collector_id: current_user.id, recipe_id: params[:recipe], favorite: params[:favorite])        
      end
    else
      current_user.recipes << Recipe.find(params[:recipe])
    end
    redirect_to root_url
  end
end
