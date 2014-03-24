class NutritionInformation < ActiveRecord::Base
  
  belongs_to :ingredient

  #validates_presence_of :ingredient_id



  #before_save normalize quantity to grams

end


