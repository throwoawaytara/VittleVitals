class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  has_many :scheduled_recipes
  has_many :users, through: :scheduled_recipes

  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  validates :name, presence: true
  validates :directions, presence: true

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
    # Collect nutrition informaton for relevant ingredients
    @ingredients_with_info = []
    recipe_ingredients = RecipeIngredient.where(recipe_id: self.id).to_a
    ingredient_ids = recipe_ingredients.map {|ingredient| ingredient.ingredient_id }
    ingredient_ids.each do |id|
      keyword = Ingredient.find(id).name
      @ingredients_with_info <<  NutritionInformation.where("name ILike ?", "%#{keyword}%").first
    end

    # Tease out calories, carbs, fat and protein for each ingredient and aggregate them
    nutrition = {
      'calories' => [],
      'calories_from_fat' => [],
      'total_fat' => [],
      'saturated_fat' => [],
      'monounsaturated_fat' => [],
      'polyunsaturated_fat' => [],
      'trans_fatty_acid' => [],
      'cholesterol' => [],
      'sodium' => [],
      'total_carbohydrate' => [],
      'dietary_fiber' => [],
      'sugars' => [],
      'protein' => []
     }
    attributes = {}
    nutrition.each_key do |key|
      attributes[key] = "nf_#{key}"
    end

    @ingredients_with_info.each do |ingredient|
      attributes.each_pair do |key, measure|
        nutrition[key] << ingredient.send("#{measure}") unless ingredient.send("#{measure}") == nil
      end
    end

    sums = {}
    nutrition.each do |n|
      sums["#{n[0]}"] = n[1].sum
    end
    sums

  end

end

