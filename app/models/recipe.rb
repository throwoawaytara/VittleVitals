class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  has_many :scheduled_recipes
  has_many :users, through: :scheduled_recipes

  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  validates :name, presence: true
  validates :directions, presence: true

  def collect_ingredients_quantities_units
    recipe_ingredients = self.ingredients
    recipe_ingredients_qty_units = {}
    recipe_ingredients.each do |ingredient|
      join_record = RecipeIngredient.where(ingredient_id: ingredient.id, recipe_id: self.id).first
      qty = join_record.ingredient_quantity
      unit = join_record.measuring_unit
      recipe_ingredients_qty_units[ingredient] = {qty: qty, unit: unit}
    end
    recipe_ingredients_qty_units
  end

  def self.search(search, method)
    if method == "recipe_name"
      @recipes = Recipe.where("name ILike ?", "%#{search}%")
    elsif method == "ingredient"
      @recipes = []
      @ingredients = Ingredient.where("name ILike ?", "%#{search}%")
      @ingredients.each do |ingredient|
        @recipes += ingredient.recipes
      end
      @recipes
    else
      @recipes = Recipe.take(20)
    end
  end

  def nutrition_calc
    @nutrition_info = []

  end

end

