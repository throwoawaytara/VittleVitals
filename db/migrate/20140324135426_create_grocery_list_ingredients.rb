class CreateGroceryListIngredients < ActiveRecord::Migration
  def change
    create_table :grocery_list_ingredients do |t|
      t.integer :ingredient_id
      t.integer :grocery_list_id
    end
  end
end
