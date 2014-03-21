class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :grocery_lists
  has_many :created_recipes, class_name: "Recipe",  foreign_key: "creator_id"
  has_many :weeks

  has_many :collected_recipes, foreign_key: :collector_id
  has_many :recipes, through: :collected_recipes, source: :collector_id

end
