class Ingredient < ActiveRecord::Base

  belongs_to :recipe_ingredient

  belongs_to :nutrition_information

  validates :name, presence: true
  validates :brand, presence: true

  

end
