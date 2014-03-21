class Recipe < ActiveRecord::Base

  has_many :collected_recipes
  has_many :collectors, through: :collected_recipes, source: :users

  has_many :grocery_list_recipes
  has_many :grocery_lists, through: :grocery_list_recipes

  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  belongs_to :day_recipes

  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  validates :name, presence: true
  validates :directions, presence: true
end
