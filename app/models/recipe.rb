class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  has_many :scheduled_recipes
  has_many :users, through: :scheduled_recipes

  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  validates :name, presence: true
  validates :directions, presence: true

  def self.search(search, method)
    if method == "By Recipe Name"
      @recipes = Recipe.where("name ILike ?", "%#{search}%") #find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    elsif method == "By Ingredient"
      @recipes = []
      @ingredients = Ingredient.where("name ILike ?", "%#{search}%")
      @ingredients.each do |ingredient|
        @recipes += ingredient.recipes
      end
      @recipes
    else
      @recipes = Recipe.take(20)
    end
  end
end


# @ingredient = Ingredient.includes(:recipes).where("name is ILike %params[:name]").first.recipes
