class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.integer :week_id
      t.string :name

      t.timestamps
    end
  end
end
