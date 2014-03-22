class CreateNutritionInformation < ActiveRecord::Migration
  def change
    create_table :nutrition_informations do |t|
      t.integer  :ingredient_id
      t.string   :brand_name
      t.string   :item_name
      t.integer  :brand_id
      t.integer  :item_id
      t.integer  :upc
      t.string   :item_type
      t.string   :item_description
      t.text   :nf_ingredient_statement
      t.float  :nf_water_grams
      t.float  :nf_calories
      t.float  :nf_calories_from_fat
      t.float  :nf_total_fat
      t.float  :nf_saturated_fat
      t.float  :nf_monounsaturated_fat
      t.float  :nf_polyunsaturated_fat
      t.float  :nf_trans_fatty_acid
      t.float  :nf_cholesterol
      t.float  :nf_sodium
      t.float  :nf_total_carbohydrate
      t.float  :nf_dietary_fiber
      t.float  :nf_sugars
      t.float  :nf_protein
      t.float  :nf_vitamin_a_iu
      t.float  :nf_vitamin_a_dv
      t.float  :nf_vitamin_c_mg
      t.float  :nf_vitamin_c_dv
      t.float  :nf_calcium_mg
      t.float  :nf_calcium_dv
      t.float  :nf_iron_mg
      t.float  :nf_iron_dv
      t.float  :nf_refuse_pct
      t.float  :nf_servings_per_container
      t.float  :nf_serving_size_qty
      t.float  :nf_serving_size_unit
      t.float  :nf_serving_weight_grams
      t.boolean  :allergen_contains_milk
      t.boolean  :allergen_contains_eggs
      t.boolean  :allergen_contains_fish
      t.boolean  :allergen_contains_shellfish
      t.boolean  :allergen_contains_tree_nuts
      t.boolean  :allergen_contains_peanuts
      t.boolean  :allergen_contains_wheat
      t.boolean  :allergen_contains_soybeans
      t.boolean  :allergen_contains_gluten
      t.string   :nutrition_tags

      t.timestamps
    end
  end
end
