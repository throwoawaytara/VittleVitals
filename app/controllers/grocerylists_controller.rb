class GrocerylistsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @ingredients = @recipe.ingredients
    unless current_user.grocery_lists.first
      @grocery_list = GroceryList.create(user_id: current_user.id, name: "GroceryList")
    else
      @grocery_list = current_user.grocery_lists.first
    end
    # @grocery_list.recipes << @recipe
    # @grocery_list.ingredients << @ingredients

    if !@grocery_list.recipes.include?(Recipe.find(@recipe.id))
      @grocery_list.recipes << @recipe
    end
    @ingredients.each do |ingredient|
      if !@grocery_list.ingredients.include?(Ingredient.find(ingredient.id))
        @grocery_list.ingredients << ingredient
      end
    end



    redirect_to "/users/#{current_user.id}/grocerylists/#{@grocery_list.id}"


  end
  def show
    if current_user
      @grocery_list = current_user.grocery_lists.first
      @list_items = @grocery_list.ingredients
    else
      redirect_to '/'
    end
  end

  private 

  # def grocery_list_params
  #   params.permit(:recipe_id, :user_id, :ingredients)
  # end
end

# @recipe = Recipe.find(params[:recipe_id])
#     @ingredients = @recipe.ingredients
#     unless current_user.grocery_lists.first
#       @grocery_list = GroceryList.create(user_id: current_user.id, name: "GroceryList")
#     else
#       @grocery_list = current_user.grocery_lists.first
#     end

#     # binding.pry

#     if @grocery_list.recipes.include?(Recipe.find(@recipe.id))

#       @grocery_list.recipes << @recipe
#     end
#     @ingredients.each do |ingredient|
#       if @grocery_list.ingredients.include?(Ingredient.find(ingredient.id))
#         @grocery_list.ingredients << ingredient
#       end
#     end

#     redirect_to "/users/#{current_user.id}/grocerylists/#{@grocery_list.id}"
