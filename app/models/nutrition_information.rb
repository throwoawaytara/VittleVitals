class NutritionInformation < ActiveRecord::Base
  belongs_to :ingredient

  validates :item_name, presence: true
  validates :ingredient_id, presence: true
  validates :item_description, presence: true
  validates :nf_serving_size_qty, presence: true

  validates_presence_of :ingredient_id

  #before_save normalize quantity to grams

end
