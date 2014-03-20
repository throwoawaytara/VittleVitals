class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :creator_id
      t.string :name
      t.text :directions
      # How do we save an image?
      t.timestamps
    end
  end
end
