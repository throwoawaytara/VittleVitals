class CreateDaysRecipes < ActiveRecord::Migration
  def change
    create_table :days_recipes do |t|
      t.integer :recipe_id
      t.integer :day_id
    end
  end
end
