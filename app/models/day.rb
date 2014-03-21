class Day < ActiveRecord::Base
  belongs_to :week

  has_many :day_recipes
  has_many :recipes, through: :day_recipes
end
