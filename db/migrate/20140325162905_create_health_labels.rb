class CreateHealthLabels < ActiveRecord::Migration
  def change
    create_table :health_labels do |t|
      t.string :label_name
      t.integer :ingredient_id

      t.timestamps
    end
  end
end
