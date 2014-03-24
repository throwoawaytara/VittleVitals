class CreateNutritionInformation < ActiveRecord::Migration
  def change
    create_table :nutrition_informations do |t|

      t.integer :ingredient_id
      t.string  :db_no                # 5-digit Nutrient Databank number
      t.text    :name                 # short ingredient description/name
      t.float   :water                # g/100g
      t.integer :calories             # kcal/100g
      t.float   :protein              # g/100g
      t.float   :total_fat            # g/100g
      t.float   :ash                  # g/100g   
      t.float   :carbs                # Carbohydrate, by difference (g/100g)
      t.float   :fiber                # g/100g
      t.float   :sugars               # g/100g
      t.float   :calcium              # mg/100g
      t.float   :iron                 # mg/100g
      t.float   :magnesium            # mg/100g
      t.float   :phosphorus           # mg/100g
      t.float   :potassium            # mg/100g
      t.float   :sodium               # mg/100g
      t.float   :zinc                 # mg/100g
      t.float   :copper               # mg/100g
      t.float   :manganese            # mg/100g
      t.float   :selenium             # micrograms/100g
      t.float   :vit_c                # mg/100g
      t.float   :thiamin              # mg/100g
      t.float   :riboflavin           # mg/100g
      t.float   :niacin               # mg/100g
      t.float   :panto_acid           # mg/100g
      t.float   :vit_b6               # mg/100g
      t.float   :folate_total         # micrograms/100g
      t.float   :folic_acid           # micrograms/100g
      t.float   :food_folate          # micrograms/100g
      t.float   :folate_dfe           # (microgram dietary folate equivalents)/100g
      t.float   :choline_tot          # mg/100g
      t.float   :vit_b12              # micrograms/100g
      t.integer :vit_a_iu             # IU/100g
      t.float   :vit_a_rae            # (micrograms retinol activity equivalents / 100g)
      t.float   :retinol              # micrograms/100g
      t.float   :alpha_carot          # micrograms/100g
      t.float   :beta_carot           # micrograms/100g
      t.float   :beta_crypt           # micrograms/100g
      t.float   :lycopene             # micrograms/100g
      t.float   :lut_zeaz             # Lutein+zeazanthin (micrograms/100g)
      t.float   :vit_e                # Vitamin E (alpha-tocopherol) (mg/100g)
      t.float   :vit_d_mcg            # Vitamin D (micrograms/100g)
      t.integer :vivit_d_iu           # Vitamin D ( IU/100g )
      t.float   :vit_k                # micrograms/100g
      t.float   :fa_sat               # g/100g
      t.float   :fa_mono              # g/100g
      t.float   :fa_poly              # g/100g
      t.float   :cholestrl            # mg/100g
      t.float   :gram_weight_a        # Gram weight of gram_weight_unit_a
      t.string  :gram_weight_unit_a   # Unit containing the number of grams from gram_we  ght_a 
      t.float   :gram_weight_b        # Gram weight of gram_weight_unit_b
      t.string  :gram_weight_unit_b   # Unit containing the number of grams from gram_we  ght_b
      t.float   :refuse_pc              # Percent refuse (?)

      t.timestamps
    end
    add_index :nutrition_informations, :ingredient_id
  end
end
