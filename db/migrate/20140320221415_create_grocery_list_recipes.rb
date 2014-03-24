class CreateGroceryListRecipes < ActiveRecord::Migration
  def change
    create_table :grocery_list_recipes do |t|
      t.integer :recipe_id
      t.integer :grocery_list_id
    end
  end
end
