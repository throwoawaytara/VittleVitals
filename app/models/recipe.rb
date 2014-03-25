class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  has_many :scheduled_recipes
  has_many :users, through: :scheduled_recipes

  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  validates :name, presence: true
  validates :directions, presence: true

  def instruction_url_split
    link = self.directions
    domain = link.split("//")[1].split("/")[0]
    domain
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

  def self.import_recipes(query)
    recipe = get_recipe_from_yummly(query)
    recipe_id = recipe.matches.first["id"]
    # ingredients_arr = recipe.matches.first["ingredients"]
    recipe_details = get_details_from_yummly(recipe_id)
    ingredients_quantity = recipe_details.json['ingredientLines']
    serving_size = recipe_details.json['numberOfServings']
    recipe_name = recipe.matches.first["recipeName"]
    recipe_directions = recipe_details.json['source']['sourceRecipeUrl']
    recipe_image = recipe_details.json['images'].first['hostedLargeUrl']

    recipe = Recipe.create(name: recipe_name,
                  directions: recipe_directions,
                  img_path: recipe_image,
                  serving_size: serving_size)

    ingredients_quantity.each do |ingredient|
      recipe.ingredients << Ingredient.create(name: ingredient)
    end
  end

  def self.get_recipe_from_yummly(query)
    Yummly.search(query, {max: 1})
  end

  def self.get_details_from_yummly(recipe_id)
    Yummly.find(recipe_id)
  end


 def nutrition_calc
   attributes = {
     :calories => "calories",
     :total_fat => "total fat",
     :fa_sat => "saturated fat",
     :fa_mono => "monounsaturated fat",
     :fa_poly => "polyunsaturated fat",
     :cholestrl => "cholesterol",
     :carbs => "carbohydrates",
     :sugars => "sugars",
     :fiber => "dietary fiber",
     :protein => "protein"
     }
  end

  
  
end

