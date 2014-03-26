class CollectedRecipesController < ActionController::Base
  
  def show
    @recipes = current_user.recipes
    redirect_to user_recipes_path(current_user)
  end

  def create
    if request.xhr?
      current_user.recipes << Recipe.find(params[:recipe_id])
      params[:recipe_id]
    else
      @recipes = Recipe.all
      render "welcome/index"
    end

      # if params[:favorite]
      #   if current_user.recipes.exists?(params[:recipe])
      #     collected = current_user.collected_recipes.where(recipe_id: params[:recipe]).first
      #     collected.favorite = params[:favorite]
      #     collected.save
      #   else
      #     CollectedRecipe.create(collector_id: current_user.id, recipe_id: params[:recipe], favorite: params[:favorite])        
      #   end
      # else
      #   current_user.recipes << Recipe.find(params[:recipe])
      # end
      # redirect_to user_recipes_path(current_user)

    end



  def destroy
    recipe = CollectedRecipe.where(collector_id: current_user.id, recipe_id: params[:id])
    recipe.destroy
    redirect_to user_recipes_path
  end
end
