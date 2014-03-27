class CollectedRecipesController < ActionController::Base
  
  def show
    @recipes = current_user.recipes
    redirect_to user_recipes_path(current_user)
  end

  def create
    if request.xhr?
      @recipe = Recipe.find(params[:recipe_id])
      unless current_user.recipes.exists?(@recipe)
        CollectedRecipe.create(collector_id: current_user.id, recipe_id: @recipe.id)
        @recipes = current_user.collected_recipes.map do |r|
          Recipe.find(r.recipe_id)
        end
        render partial: "application/recipe_list", locals: {recipes: @recipes}
      end 
    else
      redirect_to user_recipes_path(current_user)
    end
    
      # render user_recipes_path(current_user), layout:false, locals: {recipes: @recipes}
      # params[:recipe_id]
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

    # end



  def destroy
    if request.xhr?
      @recipe = CollectedRecipe.where(collector_id: params[:collector_id], recipe_id: params[:recipe_id]).first
      @recipe.destroy
      @recipes = current_user.recipes
      render user_collected_recipes_path(current_user), layout: false, locals: {recipes: @recipes}
    else
      # render "grocerylists/show", layout: true if !request.xhr?
    end
  end
end
