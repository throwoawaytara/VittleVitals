class RecipeIngredient < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :recipe

  validates_presence_of :ingredient_id, :recipe_id
end

