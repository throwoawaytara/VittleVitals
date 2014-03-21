class CreateScheduledRecipes < ActiveRecord::Migration
  def change
    create_table :scheduled_recipes do |t|
      t.date
      t.recipe_id
      t.user_id

      t.timestamps
    end
  end
end
