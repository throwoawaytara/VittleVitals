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
      t.string   :nf_ingredient_statement
      t.integer  :nf_water_grams
      t.integer  :nf_calories
      t.integer  :nf_calories_from_fat
      t.integer  :nf_total_fat
      t.integer  :nf_saturated_fat
      t.integer  :nf_monounsaturated_fat
      t.integer  :nf_polyunsaturated_fat
      t.integer  :nf_trans_fatty_acid
      t.integer  :nf_cholesterol
      t.integer  :nf_sodium
      t.integer  :nf_total_carbohydrate
      t.integer  :nf_dietary_fiber
      t.integer  :nf_sugars
      t.integer  :nf_protein
      t.integer  :nf_vitamin_a_iu
      t.integer  :nf_vitamin_a_dv
      t.integer  :nf_vitamin_c_mg
      t.integer  :nf_vitamin_c_dv
      t.integer  :nf_calcium_mg
      t.integer  :nf_calcium_dv
      t.integer  :nf_iron_mg
      t.integer  :nf_iron_dv
      t.integer  :nf_refuse_pct
      t.integer  :nf_servings_per_container
      t.integer  :nf_serving_size_qty
      t.integer  :nf_serving_size_unit
      t.integer  :nf_serving_weight_grams
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
