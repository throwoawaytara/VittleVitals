class RecipeIngredient < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :recipe

  validates :ingredient_quantity, presence: true

  validates_presence_of :ingredient_id, :recipe_id
end

