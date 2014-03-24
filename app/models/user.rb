class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # CODE REVIEW: everywhere I see grocery_lists used in code, it's used in
  # conjunction #first. Should user "has one grocery_list"?
  has_many :grocery_lists

  has_many :created_recipes, class_name: "Recipe",  foreign_key: "creator_id"

  has_many :scheduled_recipes
  has_many :upcoming_week_recipes, through: :scheduled_recipes, :source => :recipe

  has_many :collected_recipes, foreign_key: :collector_id
  has_many :recipes, through: :collected_recipes

end
