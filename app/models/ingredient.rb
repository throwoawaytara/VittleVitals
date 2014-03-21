class Ingredient < ActiveRecord::Base

  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  has_one :nutrition_information

  validates :name, presence: true
  validates :brand, presence: true



end
