class GrocerylistsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @ingredients = @recipe.ingredients
    unless current_user.grocery_lists.first
      @grocery_list = GroceryList.create(user_id: current_user.id, name: "GroceryList")
    else
      @grocery_list = current_user.grocery_lists.first
    end
    @grocery_list.recipes << @recipe
    @grocery_list.ingredients << @ingredients

    redirect_to "/users/#{current_user.id}/grocerylists/#{@grocery_list.id}"


  end
  def show
    if current_user
      @grocery_list = current_user.grocery_lists.first
      @list_items = []
      if @grocery_list
        @grocery_list.recipes.map do |recipe|
          @list_items << recipe.ingredients.to_a
        end
        @list_items.flatten!
      end
      @list_items
    else
      redirect_to '/'
    end
  end

  private 

  # def grocery_list_params
  #   params.permit(:recipe_id, :user_id, :ingredients)
  # end
end

