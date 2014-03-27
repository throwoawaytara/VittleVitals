class GrocerylistsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @ingredients = @recipe.ingredients
    unless current_user.grocery_list
      @grocery_list = GroceryList.create(user_id: current_user.id, name: "GroceryList")
    else
      @grocery_list = current_user.grocery_list
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
      @list_items = []
      @grocery_list = current_user.grocery_list
      if @grocery_list
        @list_items = @grocery_list.ingredients
      end
    else
      redirect_to '/'
    end
  end

  def destroy
    @grocery_list = GroceryList.find(params[:id])
    @grocery_list.ingredients.delete( Ingredient.find(params[:ingredient_id]))
    if @grocery_list.ingredients.all.empty?
      @grocery_list.destroy
    end

    redirect_to "/users/#{current_user.id}/grocerylists/#{@grocery_list.id}"

  end

  def shopping
    if current_user
      @list_items = []
      @grocery_list = current_user.grocery_list
      if @grocery_list
        @list_items = @grocery_list.ingredients
      end
    else
      redirect_to '/'
    end
  end

end

