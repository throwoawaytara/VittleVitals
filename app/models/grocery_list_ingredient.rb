class GroceryListIngredient < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :grocery_list

  validates_presence_of :grocery_list_id
end

