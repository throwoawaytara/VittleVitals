class NutritionInformation < ActiveRecord::Base
  
  belongs_to :recipe

  #validates_presence_of :ingredient_id



  #before_save normalize quantity to grams

end


