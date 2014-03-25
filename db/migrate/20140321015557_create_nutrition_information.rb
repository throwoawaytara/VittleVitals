class CreateNutritionInformation < ActiveRecord::Migration
  def change
    create_table :nutrition_informations do |t|
      t.integer :recipe_id
      t.integer :servings
      t.integer :calories

      t.timestamps
    end
    add_index :nutrition_informations, :ingredient_id
  end
end
