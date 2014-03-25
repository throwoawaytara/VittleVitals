require 'spec_helper'

feature "navbar" do
  scenario "navigating with the navbar" do 
    user = User.create(email: 'cat@cat.com', password: 'password')
    create_recipe
    log_in(user)
    expect(current_path).to eq(root_path)
    
    click_link "Search All Recipes"
    expect(current_path).to eq(root_path)
    expect(page.find(".page-title")).to have_content("Search Recipes")
    
    click_link "My Recipes"
    expect(current_path).to eq(user_recipes_path(user))
    expect(page.find(".page-title")).to have_content("My Recipes")

    click_link "My Grocery List"
    expect(current_path).to eq(user_grocerylist_path(user, 1)) #this is a smell.  User should have one grocery list
    expect(page.find(".page-title")).to have_content("Grocery List")

    click_link "My Week"
    expect(current_path).to eq(user_scheduled_recipes_path(user))
    expect(page.find(".page-title")).to have_content("This Week's Recipes")

    click_link "My Account"
    expect(current_path).to eq(edit_user_registration_path)
    expect(page).to have_content("Edit User")

  end

  scenario "thing" do
    
  end

  def log_in(user)
    visit root_path
    click_on "Login"
    fill_in 'Email', :with => 'cat@cat.com'
    fill_in 'Password', :with => 'password'
    click_button "Sign in"
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
