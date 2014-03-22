class GrocerylistsController < ApplicationController
  def show
    @grocery_list = current_user.grocery_lists.first 
  end
end