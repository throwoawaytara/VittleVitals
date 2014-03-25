require 'net/http'
require 'net/https'
require 'uri'
require 'json'

class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  has_many :scheduled_recipes
  has_many :users, through: :scheduled_recipes

  has_one :nutrition_information

  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  validates :name, presence: true
  validates :directions, presence: true

  # after_create :get_nutrition_information

  # def get_nutrition_information
  #   nutrition_json = query_nutritionix(self.name)
  #   # binding.pry
  #   args = {}
  #   args["recipe_id"] = self.id
  #   nutrition_json["hits"][0]["fields"].each do |field, value|
  #     unless value.is_a? Array
  #       args[field] = value
  #     else
  #       args[field] = value[0]
  #     end
  #   end
  #   NutritionInformation.create(args)

  # end

  def query_edamam

    params = {title: self.name,"yield" => self.serving_size, ingr: self.ingredients.map(&:name)}
    uri = URI.parse("https://api.edamam.com/api/nutrient-info?extractOnly&app_id=#{ENV["EDAMAM_APP_ID"]}app_key=$#{ENV["EDAMAM_APP_KEY"]}")
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' => 'application/json'})
    request.body = "[ #{params} ]"
    response = https.request(request)

    # @json_response = Net::HTTP.post_form(uri, {title: self.name,
    #                                            "yield" => self.serving_size,
    #                                            ingr: self.ingredients.map(&:name)})
    puts "+++++++++++++++++++++++++++++++++++++++++++++++"
    puts response 

    # begin
    #   return JSON.parse(@json_response)
    # rescue Exception => e
    #   puts e.message
    #   puts "retrying.."
    #   retry
    # end

  end

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


  def nutrition
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
    #:calcium,:iron,:magnesium,:phosphorus,:potassium,:sodium,:zinc,:copper,:manganese,:selenium,:vit_c,:thiamin,:riboflavin,:niacin,:panto_acid,:vit_b6,:folate_total,:folic_acid,:food_folate,:folate_dfe,:choline_tot,:vit_b12,:vit_a_iu,:vit_a_rae,:retinol,:alpha_carot,:beta_carot,:beta_crypt,:lycopene,:lut_zeaz,:vit_e,:vit_d_mcg,:vivit_d_iu,:vit_k,:sodium => "sodium"

    recipe_stats = {}
    unloaded = []

    ingredients = self.ingredients.to_a

    ingredient_units = {}

    ingredients.each do |ingredient|

      ing_info = ingredient.nutrition_information
      ingredient_units[ingredient.name] = {
        :gram_weight_a => ing_info.gram_weight_a,
        :gram_weight_unit_a => ing_info.gram_weight_unit_a,
        :gram_weight_b => ing_info.gram_weight_b,
        :gram_weight_unit_b => ing_info.gram_weight_unit_b
      }
    end
    # this will be replaced with self.num_servings once that's a field

    recipe_num_servings = 4
    attributes.each_pair do |a, name|
      recipe_stats[name] = []
      ingredients.each do |ingredient|
        recipe_ingredient = RecipeIngredient.where(recipe_id: self.id, ingredient_id: ingredient.id).first
        # divide the quantity by num servings per recipe to determine how much of the ingredient tehre is per serving
        ing_quant_per_recipe_serving = recipe_ingredient.ingredient_quantity / recipe_num_servings
        # we will have to do some conversion work eventually,... right now all ings are in grams, which is easy
        ing_unit = recipe_ingredient.measuring_unit
        ing_info = ingredient.nutrition_information
        # ingredient quantity is in grams, and the nut data is g/100g for the attributes we're displaying, so we need to divide by 100
        multiplier = 100
        recipe_stats[name] << ing_info.send(a) * (ing_quant_per_recipe_serving.to_f/multiplier) unless ing_info.send(a) == nil
        unloaded << ingredient.name unless unloaded.include?(ingredient.name)
      end
    end

    # we still need a method to determine whether we have the ingredient or not

    recipe_stats.each_pair do |ingredient, nums|
      recipe_stats[ingredient] = nums.flatten.sum.to_f
    end

    {stats: recipe_stats, unloaded: unloaded, ingredient_units: ingredient_units}

  end
end

