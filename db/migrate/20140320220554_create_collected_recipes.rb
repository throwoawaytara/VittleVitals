class CreateCollectedRecipes < ActiveRecord::Migration
  def change
    create_table :collected_recipes do |t|
      t.integer :recipe_id
      t.integer :collector_id
      t.boolean :favorite

      t.timestamps
    end
  end
end
