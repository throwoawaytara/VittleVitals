class GroceryListsController < ApplicationController
  def index
      <% @grocery_list.recipes.each do |recipe| %>
    <% recipe.ingredients.each do |ingredient| %>
  end

end