class GroceryList < ActiveRecord::Base
  
  belongs_to :user

  # CODE REVIEW: why does this join table support both the recipes and
  # ingredients to grocery lists?
  has_many :grocery_list_recipes
  has_many :recipes, through: :grocery_list_recipes
  has_many :ingredients, through: :grocery_list_recipes

  validates :name, presence: true

  validates_presence_of :user_id
end
