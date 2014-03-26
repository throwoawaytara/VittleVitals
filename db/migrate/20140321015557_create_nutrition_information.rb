class CreateNutritionInformation < ActiveRecord::Migration
  def change
    create_table :nutrition_informations do |t|

      t.integer :recipe_id
      t.string :name
      t.float :value
      t.string :unit

      t.timestamps
    end
  end
end


