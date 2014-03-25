class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :creator_id
      t.string :name
      t.text :directions
      t.string :img_path
      t.integer :serving_size

      t.timestamps
    end
  end
end
