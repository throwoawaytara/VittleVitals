class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  has_many :scheduled_recipes
  has_many :users, through: :scheduled_recipes

  has_many :nutrition_informations

  has_many :health_labels

  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  validates :name, presence: true
  validates :directions, presence: true

  def get_nutrition_information
    nutrition = query_edamam

    NutritionInformation.create(recipe_id: self.id, name: "calories", value: nutrition["calories"] )
    # binding.pry
    args = {}
    args["recipe_id"] = self.id

    nutrition["totalNutrients"].each do | nutrient_label, nutrient_values|
      args["name"] = nutrient_values["label"]
      args["value"] = nutrient_values["quantity"]
      args["unit"] = nutrient_values["unit"]  
      nutrition_information = NutritionInformation.create(args)
    end
    nutrition["healthLabels"].each { |label_name| HealthLabel.create(recipe_id: self.id, label_name: label_name)}
    self.nutrition_calc

  end

  def query_edamam

    params = {title: self.name,"yield" => self.serving_size.to_s, ingr: self.ingredients.map(&:name)}.to_json
    uri = URI.parse("https://api.edamam.com/api/nutrient-info?extractOnly&app_id=#{ENV["EDAMAM_APP_ID"]}&app_key=#{ENV["EDAMAM_APP_KEY"]}")
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri)
    request.content_type = "application/json"
    request.body = params
    response = https.request(request).body

    JSON.parse(response)

    begin
      return JSON.parse(response)
    rescue Exception => e
      puts e.message
      puts "retrying.."
      retry
    end

  end

  def instruction_url_split
    link = self.directions
    domain = link.split("//")[1].split("/")[0]
    domain
  end

  def self.search(search)
    @recipes = Recipe.where("name ILike ?", "%#{search}%")
    @ingredients = Ingredient.where("name ILike ?", "%#{search}%")
    @ingredients.each do |ingredient|
      @recipes += ingredient.recipes
    end
    @recipes.uniq
  end

  def self.import_recipes(query)
    recipe = get_recipe_from_yummly(query)
    recipe_id = recipe.matches.first["id"]
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
    nutrition_infos = self.nutrition_informations
    nutrition_infos.each do |nutrition_info|
      value = nutrition_info.value
      nutrition_info.update_attributes(value:  value / self.serving_size)
    end
  end

  def is_user_favorite?(current_user)
    CollectedRecipe.where(recipe_id: self.id, collector_id: current_user.id).first.favorite == true
  end
  
  
end

