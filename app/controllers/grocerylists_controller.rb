class GrocerylistsController < ApplicationController
  def show
    @grocery_list = current_user.grocery_lists.first 
    @list_items = []
    @grocery_list.recipes.map do |recipe| 
      @list_items << recipe.ingredients.to_a
    end
    @list_items.flatten!
  end

  
end


