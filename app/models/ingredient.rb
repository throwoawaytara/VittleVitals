require 'net/http'
require 'uri'
require 'json'

class Ingredient < ActiveRecord::Base

  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  has_one :nutrition_information

  validates :name, presence: true

  after_create :get_nutrition_information

  def get_nutrition_information

    nutrition_json = query_nutritionix(self.name)

    args = {}
    args["ingredient_id"] = self.id
    args["name"] = self.name
    nutrition_json["hits"][0]["fields"].each do |field, value|
      unless value.is_a? Array
        args[field] = value
      else
        args[field] = value[0]
      end
    end
    NutritionInformation.create(args)

  end

  def query_nutritionix(name)
    uri = URI.parse("https://api.nutritionix.com/v1_1/search")

    @json_response = Net::HTTP.post_form(uri, {"appId" => ENV["appId"],
                                               "appKey" => ENV["appKey"],
                                               query: name,
                                               offset: 0,
                                               limit: 1,
                                               fields: ["brand_id",
                                                        "brand_name",
                                                        "item_id",
                                                        "item_name",
                                                        "nf_calories",
                                                        "upc",
                                                        "item_type",
                                                        "item_description",
                                                        "nf_ingredient_statement",
                                                        "nf_water_grams",
                                                        "nf_calories",
                                                        "nf_calories_from_fat",
                                                        "nf_total_fat",
                                                        "nf_saturated_fat",
                                                        "nf_monounsaturated_fat",
                                                        "nf_polyunsaturated_fat",
                                                        "nf_trans_fatty_acid",
                                                        "nf_cholesterol",
                                                        "nf_sodium",
                                                        "nf_total_carbohydrate",
                                                        "nf_dietary_fiber",
                                                        "nf_sugars",
                                                        "nf_protein",
                                                        "nf_vitamin_a_iu",
                                                        "nf_vitamin_a_dv",
                                                        "nf_vitamin_c_mg",
                                                        "nf_vitamin_c_dv",
                                                        "nf_calcium_mg",
                                                        "nf_calcium_dv",
                                                        "nf_iron_mg",
                                                        "nf_iron_dv",
                                                        "nf_refuse_pct",
                                                        "nf_servings_per_container",
                                                        "nf_serving_size_qty",
                                                        "nf_serving_size_unit",
                                                        "nf_serving_weight_grams",
                                                        "allergen_contains_milk",
                                                        "allergen_contains_eggs",
                                                        "allergen_contains_fish",
                                                        "allergen_contains_shellfish",
                                                        "allergen_contains_tree_nuts",
                                                        "allergen_contains_peanuts",
                                                        "allergen_contains_wheat",
                                                        "allergen_contains_soybeans",
                                                        "allergen_contains_gluten",
                                                        "nutrition_tags",
                                                        "created_at",
                                                        "updated_at"]}).body

    begin
      return JSON.parse(@json_response)
    rescue Exception => e
      puts e.message
      puts "retrying.."
      retry
    end

  end

end
