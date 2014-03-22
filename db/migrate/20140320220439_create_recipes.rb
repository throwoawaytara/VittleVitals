class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :creator_id
      t.string :name
      t.text :directions
      t.string :img_path
      # How do we save an image?
      t.timestamps
    end
  end
end
