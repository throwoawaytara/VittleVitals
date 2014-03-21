class CollectedRecipe < ActiveRecord::Base
  
  belongs_to :recipe

  belongs_to :collector, class_name: "User"

  validates_presence_of :recipe_id, :collector_id
end
