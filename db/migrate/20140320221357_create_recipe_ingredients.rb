class CreateRecipeIngredients < ActiveRecord::Migration
  def change
    create_table :recipe_ingredients do |t|
      t.integer :ingredient_id
      t.integer :recipe_id
      t.integer :ingredient_quantity
      t.string :measuring_unit

      t.timestamps
    end
  end
end
