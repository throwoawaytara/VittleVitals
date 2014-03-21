class GroceryList < ActiveRecord::Base
  belongs_to :user

  has_many :grocery_list_recipes
  has_many :recipes, through: :grocery_list_recipes
end
