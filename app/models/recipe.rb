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

  def nutrition
    ingredients = self.ingredients.to_a
    ingredient_stats = {}
    unloaded_ingredients = {}

    ingredients.each do |ingredient|
      ing_info = ingredient.nutrition_information

      ingredient_stats[ingredient] = {
        recipe_amt: RecipeIngredient.where( recipe_id: self.id, ingredient_id: ingredient.id ).first.ingredient_quantity,
        recipe_amt_unit: RecipeIngredient.where(recipe_id: self.id, ingredient_id: ingredient.id ).first.measuring_unit,
        water: ing_info.water,
        calories: ing_info.calories,
        protein: ing_info.protein,
        total_fat: ing_info.total_fat,
        carbs: ing_info.carbs,
        fiber: ing_info.fiber,
        sugars: ing_info.sugars,
        calcium: ing_info.calcium,
        iron: ing_info.iron,
        magnesium: ing_info.magnesium,
        phosphorus: ing_info.phosphorus,
        potassium: ing_info.potassium,
        sodium: ing_info.sodium,
        zinc: ing_info.zinc,
        copper: ing_info.copper,
        manganese: ing_info.manganese,
        selenium: ing_info.selenium,
        vit_c: ing_info.vit_c,
        thiamin: ing_info.thiamin,
        riboflavin: ing_info.riboflavin,
        niacin: ing_info.niacin,
        panto_acid: ing_info.panto_acid,
        vit_b6: ing_info.vit_b6,
        folate_total: ing_info.folate_total,
        folic_acid: ing_info.folic_acid,
        food_folate: ing_info.food_folate,
        folate_dfe: ing_info.folate_dfe,
        choline_tot: ing_info.choline_tot,
        vit_b12: ing_info.vit_b12,
        vit_a_iu: ing_info.vit_a_iu,
        vit_a_rae: ing_info.vit_a_rae,
        retinol: ing_info.retinol,
        alpha_carot: ing_info.alpha_carot,
        beta_carot: ing_info.beta_carot,
        beta_crypt: ing_info.beta_crypt,
        lycopene: ing_info.lycopene,
        lut_zeaz: ing_info.lut_zeaz,
        vit_e: ing_info.vit_e,
        vit_d_mcg: ing_info.vit_d_mcg,
        vivit_d_iu: ing_info.vivit_d_iu,
        vit_k: ing_info.vit_k,
        fa_sat: ing_info.fa_sat,
        fa_mono: ing_info.fa_mono,
        fa_poly: ing_info.fa_poly,
        cholestrl: ing_info.cholestrl,
        gram_weight_a: ing_info.gram_weight_a,
        gram_weight_unit_a: ing_info.gram_weight_unit_a,
        gram_weight_b: ing_info.gram_weight_b,
        gram_weight_unit_b: ing_info.gram_weight_unit_b
      }  
    end
    ingredient_stats
  end # nutrition
end

