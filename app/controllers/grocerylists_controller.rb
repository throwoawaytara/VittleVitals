class GrocerylistsController < ApplicationController
  def show
    if current_user
      @grocery_list = current_user.grocery_lists.first
      @list_items = []
      if @grocery_list
        @grocery_list.recipes.map do |recipe|
          @list_items << recipe.ingredients.to_a
        end
      end
      @list_items.flatten!
    else
      redirect_to '/'
    end
  end
end

