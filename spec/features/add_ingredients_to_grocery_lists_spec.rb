require 'spec_helper'

feature "Using Grocery List" do
  scenario "add ingrediets to grocery list" do
    user_1 = User.create(email: 'cat@cat.com', password: 'password')
    recipe_1 = create_recipe(user_1)
    log_in(user_1)
    expect(current_path).to eq(root_path)

    click_link "My Recipes"
    expect(current_path).to eq(user_recipes_path(user_1))
    expect(page.find(".page-title")).to have_content("My Recipes")

    expect(page.all(".item").count).to eq(1)
    click_link "Tofu Scramble"
    expect(current_path).to eq(recipe_path(recipe_1))
    expect(page.find(".page-title")).to have_content("Tofu Scramble")

    click_link "Add to Grocery List"
    expect(current_path).to eq(user_grocerylist_path(user_1, user_1.grocery_list)) #this is a smell.  User should have one grocery list
    expect(page.find(".page-title")).to have_content("Grocery List")

    expect(page).to have_content("firm tofu")
    expect(page).to have_content("olive oil")
    expect(page).to have_content("salt")

    #binding.pry

    page.all(".grocery-item").first.click_link('Remove')

    expect(page).to_not have_content("firm_tofu")
    expect(page).to have_content("olive oil")
    expect(page).to have_content("salt")

  end

  def log_in(user)
    visit root_path
    click_on "Login"
    fill_in 'Email', :with => 'cat@cat.com'
    fill_in 'Password', :with => 'password'
    click_button "Sign in"
  end

  def create_recipe(user_1)
    recipe_1 = Recipe.create(
      name: 'Tofu Scramble',
      img_path: "http://farm6.staticflickr.com/5506/11593981716_a09d9ff30b.jpg",
      directions: "http://veganyackattack.com/2012/08/23/tofu-scramble-for-two/"
    )
    user_1.recipes << recipe_1

    ingredients = ['firm tofu', 'olive oil', 'salt']
    ingredient_obj = []
    ingredients.each do |ingredient|
        ingredient_obj << Ingredient.create(name: ingredient)
    end
    ingredient_obj.each do |obj|
        RecipeIngredient.create(ingredient_id: obj.id,
                                recipe_id: recipe_1.id)
    end

    recipe_1
  end
end
