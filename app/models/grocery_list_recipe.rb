class GroceryListRecipe < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :grocery_list

  validates_presence_of :grocery_id, :recipe_id
end

