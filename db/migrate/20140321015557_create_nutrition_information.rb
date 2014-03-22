class CreateNutritionInformation < ActiveRecord::Migration
  def change
    create_table :nutrition_informations do |t|
      t.integer  :ingredient_id
      t.string   :brand_name
      t.string   :item_name
      t.string  :brand_id
      t.string  :item_id
      t.string  :upc
      t.string   :item_type
      t.string   :item_description
      t.string   :nf_ingredient_statement
      t.string  :nf_water_grams
      t.string  :nf_calories
      t.string  :nf_calories_from_fat
      t.string  :nf_total_fat
      t.string  :nf_saturated_fat
      t.string  :nf_monounsaturated_fat
      t.string  :nf_polyunsaturated_fat
      t.string  :nf_trans_fatty_acid
      t.string  :nf_cholesterol
      t.string  :nf_sodium
      t.string  :nf_total_carbohydrate
      t.string  :nf_dietary_fiber
      t.string  :nf_sugars
      t.string  :nf_protein
      t.string  :nf_vitamin_a_iu
      t.string  :nf_vitamin_a_dv
      t.string  :nf_vitamin_c_mg
      t.string  :nf_vitamin_c_dv
      t.string  :nf_calcium_mg
      t.string  :nf_calcium_dv
      t.string  :nf_iron_mg
      t.string  :nf_iron_dv
      t.string  :nf_refuse_pct
      t.string  :nf_servings_per_container
      t.string  :nf_serving_size_qty
      t.string  :nf_serving_size_unit
      t.string  :nf_serving_weight_grams
      t.string  :allergen_contains_milk
      t.string  :allergen_contains_eggs
      t.string  :allergen_contains_fish
      t.string  :allergen_contains_shellfish
      t.string  :allergen_contains_tree_nuts
      t.string  :allergen_contains_peanuts
      t.string  :allergen_contains_wheat
      t.string  :allergen_contains_soybeans
      t.string  :allergen_contains_gluten
      t.string   :nutrition_tags

      t.timestamps
    end
  end
end
