require 'spec_helper'

feature "CollectRecipes" do
  scenario "add a recipe to weekly list from my recipes" do
    create_recipe
    sign_up_user
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Tofu Scramble")
    collect_recipe
    visit user_recipes_path(User.last)
    expect(page.all(".item").count).to eq(1)
    assign_day_to_recipe("Monday")
    click_link "My Week"
    expect(page.find("#monday")).to have_content("Tofu Scramble")
  end

  scenario "add a recipe to the weekly list from an individual recipe" do
    create_recipe
    sign_up_user
    expect(current_path).to eq(root_path)
    collect_recipe
    click_link "Tofu Scramble"

    click_link "My Recipes"
    expect(page).to have_content("Tofu Scramble")

    assign_day_to_recipe("Tuesday")
    click_link "My Week"
    expect(page.find("#tuesday")).to have_content("Tofu Scramble")



  end

  def assign_day_to_recipe(day)
    select day, from: "day"
    click_on "Add"
  end

  def collect_recipe
    click_on "not-collected-button"
  end

  def sign_up_user
    visit root_path
    click_on "Sign up"
    fill_in 'Email', :with => 'cat@cat.com'
    fill_in 'Password', :with => 'password'
    fill_in 'Password confirmation', :with => 'password'
    click_button "Sign up"
  end

  def create_recipe
    Recipe.create(
      name: 'Tofu Scramble',
      img_path: "http://farm6.staticflickr.com/5506/11593981716_a09d9ff30b.jpg",
      directions: "http://veganyackattack.com/2012/08/23/tofu-scramble-for-two/"
    )
  end


end
