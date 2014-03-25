class CreateNutritionInformation < ActiveRecord::Migration
  def change
    create_table :nutrition_informations do |t|

      t.integer :recipe_id


      t.timestamps
    end
  end
end


