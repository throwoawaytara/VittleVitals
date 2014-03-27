class CollectedRecipesController < ActionController::Base
  
  def show
    @recipes = current_user.recipes
    redirect_to user_recipes_path(current_user)
  end

  def create
    if request.xhr?
      @recipe = Recipe.find(params[:recipe_id])
      unless current_user.recipes.include?(@recipe)
        CollectedRecipe.create(collector_id: current_user.id, recipe_id: @recipe.id)
        @recipes = current_user.collected_recipes.map do |r|
          Recipe.find(r.recipe_id)
        end
        # render partial: "application/recipe_list", locals: {recipes: @recipes}
      end 
    else
      redirect_to user_collected_recipes_path(current_user)
    end

  end


  def destroy
    if request.xhr?
      @recipe = CollectedRecipe.where(collector_id: params[:collector_id], recipe_id: params[:recipe_id]).first
      @recipe.destroy if @recipe
      @recipes = current_user.recipes
      # render "user_recipes/index", layout: false, locals: {recipes: @recipes} else
      # render "grocerylists/show", layout: true if !request.xhr?
    end
  end
end
