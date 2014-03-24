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
    ingredients_with_info = []
    recipe_ingredients = RecipeIngredient.where(recipe_id: self.id).to_a
    ingredient_ids_and_qtys = recipe_ingredients.map {|ingredient| [ingredient.ingredient_id, ingredient.ingredient_quantity] }
    ingredient_ids_and_qtys.each do |id|
      keyword = Ingredient.find(id[0]).name
      ingredients_with_info << [NutritionInformation.where("name ILike ?", "%#{keyword}%").first, id[1]]
    end

    # Tease out calories, carbs, fat and protein for each ingredient and aggregate them
    nutrition = {
      'nf_serving_size_qty' => [],
      'nf_serving_weight_grams' => [],
      'nf_calories' => [],
      'nf_total_fat' => [],
      'nf_total_carbohydrate' => [],
      'nf_protein' => []
     }

    attributes = {}
    nutrition.each_key {|key| attributes[key] = "#{key}"}

    # WE HAVE TO CONVERT EVERYTHING TO GRAMS

    # recipe serving size unit and recipe serving size qty are equiv to nut data for now, to make things easier
    compiled = {}
    ingredients_with_info.each do |i|
      attributes.each_pair do |key, measure|
        nutrition[key] << i[0].send("#{measure}") unless i[0].send("#{measure}") == nil
        compiled["#{i[0].name}_recipe_qty_grams"] = i[1]
        compiled["#{i[0].name}_serving_weight_grams"] = i[0].nf_serving_weight_grams
      end
    end

    sums = {}
    nutrition.each do |n|
      sums["#{n[0]}"] = n[1].sum
    end


    results = {
      'sums' => sums, 
      'compiled' => compiled}

  end

end

