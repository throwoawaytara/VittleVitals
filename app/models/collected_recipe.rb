class CollectedRecipe < ActiveRecord::Base
  belongs_to :recipe

  belongs_to :user, class_name: "User", foreign_key: "collector_id"
end
