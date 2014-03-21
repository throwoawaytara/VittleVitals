class CreateScheduledRecipes < ActiveRecord::Migration
  def change
    create_table :scheduled_recipes do |t|
      t.date :date
      t.integer :recipe_id
      t.integer :user_id

      t.timestamps
    end
  end
end
