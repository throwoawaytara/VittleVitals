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

    expect(page).to have_content("BUTTER,WITH SALT")
    expect(page).to have_content("BUTTER,WHIPPED,WITH SALT")
    expect(page).to have_content("BUTTER OIL,ANHYDROUS")

    #binding.pry

    page.all(".grocery-item").first.click_link('Remove')

    expect(page).to_not have_content("BUTTER,WITH SALT")
    expect(page).to have_content("BUTTER,WHIPPED,WITH SALT")
    expect(page).to have_content("BUTTER OIL,ANHYDROUS")


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
    user_1.recipes << recipe_1

    require 'csv'

    file = "#{Rails.root}/db/usda_test.csv"
    CSV.foreach(file, headers: true) do |row|
      ingredient = Ingredient.create!(name: row[1])
      NutritionInformation.create(
        ingredient_id: ingredient.id,
        db_no: row[0],
        name: row[1].downcase,
        water: row[2],
        calories: row[3],
        protein: row[4],
        total_fat: row[5],
        ash: row[6],
        carbs: row[7],
        fiber: row[8],
        sugars: row[9],
        calcium: row[10],
        iron: row[11],
        magnesium: row[12],
        phosphorus: row[13],
        potassium: row[14],
        sodium: row[15],
        zinc: row[16],
        copper: row[17],
        manganese: row[18],
        selenium: row[19],
        vit_c: row[20],
        thiamin: row[21],
        riboflavin: row[22],
        niacin: row[23],
        panto_acid: row[24],
        vit_b6: row[25],
        folate_total: row[26],
        folic_acid: row[27],
        food_folate: row[28],
        folate_dfe: row[29],
        choline_tot: row[30],
        vit_b12: row[31],
        vit_a_iu: row[32],
        vit_a_rae: row[33],
        retinol: row[34],
        alpha_carot: row[35],
        beta_carot: row[36],
        beta_crypt: row[37],
        lycopene: row[38],
        lut_zeaz: row[39],
        vit_e: row[40],
        vit_d_mcg: row[41],
        vivit_d_iu: row[42],
        vit_k: row[43],
        fa_sat: row[44],
        fa_mono: row[45],
        fa_poly: row[46],
        cholestrl: row[47],
        gram_weight_a: row[48],
        gram_weight_unit_a: row[49],
        gram_weight_b: row[50],
        gram_weight_unit_b: row[51],
        refuse_pc: row[52])
      end

    RecipeIngredient.create(ingredient_id: Ingredient.all[0].id, recipe_id: recipe_1.id)
    RecipeIngredient.create(ingredient_id: Ingredient.all[1].id, recipe_id: recipe_1.id)
    RecipeIngredient.create(ingredient_id: Ingredient.all[2].id, recipe_id: recipe_1.id)
  
    recipe_1 
  end

end
