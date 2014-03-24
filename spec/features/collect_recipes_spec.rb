require 'spec_helper'

feature "CollectRecipes" do
  scenario "add a recipe to weekly list" do
    create_recipe
    sign_up_user
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Tofu Scramble")
    collect_recipe
    visit user_recipes_path(User.last)
    expect(page.all(".item").count).to eq(1)
    assign_day_to_recipe
    click_link "My Week"
    expect(page.find("#monday")).to have_content("Tofu Scramble")
  end

  def assign_day_to_recipe
    select "Monday", from: "day"
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
      directions: <<-DIRECTIONS
Preheat a large, heavy bottomed pan over medium high heat.
Saute the garlic in olive oil for about a minute.
Break the tofu apart into bite sized pieces and saute for about 10 minutes, using a spatula to stir often.
Get under the tofu when you are stirring, scrape the bottom and don’t let it stick to the pan, that is where the good, crispy stuff is.
Use a thin metal spatula to get the job done, a wooden or plastic one won’t really cut it.
The tofu should get browned on at least one side, but you don’t need to be too precise about it.
The water should cook out of it and not collect too much at the bottom of the ban.
If that is happening, turn the heat up and let the water evaporate.
Add the spice blend and mix to incorporate.
Add the nutritional yeast and fresh black pepper.
Cook for about 5 more minutes.
Serve warm.
DIRECTIONS
    )
  end


end
