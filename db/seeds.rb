# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Need to had a favorite recipe for a user
# Need to add a recipe to the schedule for a user

user = User.create(email: 'cat@cat.com', password: 'password')

remote_images = ["http://farm6.staticflickr.com/5506/11593981716_a09d9ff30b.jpg","http://farm4.staticflickr.com/3690/11593332413_2e0d112cc8.jpg","http://placehold.it/350x150"]
images = ["/images/neon-green.gif","/images/forest-green.gif","/images/brown.gif","/images/orange.gif","/images/purple.gif"]


Recipe.import_recipes("lasagna")
Recipe.import_recipes("tofu")
Recipe.import_recipes("pulled pork")
Recipe.import_recipes("meatloaf")
Recipe.import_recipes("cookies")
Recipe.import_recipes("pot roast")
Recipe.import_recipes("chicken")
Recipe.import_recipes("fish")
Recipe.import_recipes("baked potato")
Recipe.import_recipes("beef stew")
Recipe.import_recipes("quinoa")
Recipe.import_recipes("lemon")
Recipe.import_recipes("salmon")
Recipe.import_recipes("pasta")

user.recipes << Recipe.find(4)
user.recipes << Recipe.find(1)
user.recipes << Recipe.find(10)

# ingredient_1 = Ingredient.create(name: 'Cheese', brand: 'Kraft')
# ingredient_2 = Ingredient.create(name: 'Butter', brand: "I can't believe it's not Butter!")
# ingredient_3 = Ingredient.create(name: 'Flour', brand: 'SomeBrand')
# ingredient_4 = Ingredient.create(name: 'Milk', brand: 'CowMilk')
# ingredient_5 = Ingredient.create(name: 'Paprika', brand: 'OffBrand')
# ingredient_6 = Ingredient.create(name: 'Macaroni', brand: 'Noodles.com')
# ingredient_7 = Ingredient.create(name: 'Mystery Powder', brand: 'ShadyPlace.co')

# ingredient_8 = Ingredient.create(name: 'Broccoli', brand: 'Nature')
# ingredient_9 = Ingredient.create(name: 'Green Onions', brand: 'Nature')
# ingredient_10 = Ingredient.create(name: 'Unsalted Peanuts', brand: 'Nature')
# ingredient_11 = Ingredient.create(name: 'Sunflower Seeds', brand: 'Nature')
# ingredient_12 = Ingredient.create(name: 'Vegetable Oil', brand: 'Slick')
# ingredient_13 = Ingredient.create(name: 'Cider Vineger', brand: 'Vineger inc')
# ingredient_14 = Ingredient.create(name: 'White Sugar', brand: 'Domino')
# ingredient_15 = Ingredient.create(name: 'Lime Juice', brand: 'Nature')
# ingredient_16 = Ingredient.create(name: 'Cilantro', brand: 'Nature')

# ingredient_17 = Ingredient.create(name: 'Tofu', brand: 'TofuIsAwesome')
# ingredient_18 = Ingredient.create(name: 'Garlic', brand: 'Nature')
# ingredient_19 = Ingredient.create(name: 'Black Pepper', brand: 'Nature')
# ingredient_20 = Ingredient.create(name: 'Yeast', brand: 'Nature')
# ingredient_21 = Ingredient.create(name: 'Garlic', brand: 'Nature')

# ingredient_22 = Ingredient.create(name: 'Milk', brand: 'Nature')
# ingredient_23 = Ingredient.create(name: 'Soy Sauce', brand: 'Kikkoman')
# ingredient_24 = Ingredient.create(name: 'Black Pepper', brand: 'Nature')
# ingredient_25 = Ingredient.create(name: 'Greenbeans', brand: 'Nature')
# ingredient_26 = Ingredient.create(name: 'Onions', brand: 'Nature')

# ingredient_27 = Ingredient.create(name: 'Water', brand: 'Dasani')
# ingredient_28 = Ingredient.create(name: 'Sugar', brand: 'Nature')
# ingredient_29 = Ingredient.create(name: 'Corn Syrup', brand: 'Nature')
# ingredient_30 = Ingredient.create(name: 'Orange Juice', brand: 'Tropicana')
# ingredient_31 = Ingredient.create(name: 'Orange Zest', brand: 'Nature')
# ingredient_32 = Ingredient.create(name: 'Gelatin', brand: 'Nature')
# ingredient_33 = Ingredient.create(name: 'Vanilla', brand: 'Nature')
# ingredient_34 = Ingredient.create(name: 'Pistachios', brand: 'Nature')

require 'csv'

file = "#{Rails.root}/db/usda_nutrition_db.csv"
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

RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_1.id, ingredient_quantity: 100 * 2, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_1.id, ingredient_quantity: 100 * 1, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_1.id, ingredient_quantity: 100 * 3, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_1.id, ingredient_quantity: 100 * 1, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_1.id, ingredient_quantity: 100 * 2, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_1.id, ingredient_quantity: 100 * 1, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_1.id, ingredient_quantity: 100 * 5, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_6.id, ingredient_quantity: 100 * 2, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_6.id, ingredient_quantity: 100 * 1, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_6.id, ingredient_quantity: 100 * 3, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_6.id, ingredient_quantity: 100 * 1, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_6.id, ingredient_quantity: 100 * 2, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_6.id, ingredient_quantity: 100 * 1, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_6.id, ingredient_quantity: 100 * 5, measuring_unit: "g")

RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_2.id, ingredient_quantity: 100 * 2, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_2.id, ingredient_quantity: 100 * 1, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_2.id, ingredient_quantity: 100 * 3, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_2.id, ingredient_quantity: 100 * 1, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_2.id, ingredient_quantity: 100 * 2, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_2.id, ingredient_quantity: 100 * 1, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_2.id, ingredient_quantity: 100 * 5, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_2.id, ingredient_quantity: 100 * 1, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_2.id, ingredient_quantity: 100 * 5, measuring_unit: "g")

RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_7.id, ingredient_quantity: 100 * 2, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_7.id, ingredient_quantity: 100 * 1, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_7.id, ingredient_quantity: 100 * 3, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_7.id, ingredient_quantity: 100 * 1, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_7.id, ingredient_quantity: 100 * 2, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_7.id, ingredient_quantity: 100 * 1, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_7.id, ingredient_quantity: 100 * 5, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_7.id, ingredient_quantity: 100 * 1, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_7.id, ingredient_quantity: 100 * 5, measuring_unit: "g")

RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_3.id, ingredient_quantity: 100 * 2, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_3.id, ingredient_quantity: 100 * 1, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_3.id, ingredient_quantity: 100 * 3, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_3.id, ingredient_quantity: 100 * 1, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_3.id, ingredient_quantity: 100 * 2, measuring_unit: "g")

RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_8.id, ingredient_quantity: 100 * 2, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_8.id, ingredient_quantity: 100 * 1, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_8.id, ingredient_quantity: 100 * 3, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_8.id, ingredient_quantity: 100 * 1, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_8.id, ingredient_quantity: 100 * 2, measuring_unit: "g")

RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_4.id, ingredient_quantity: 100 * 2, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_4.id, ingredient_quantity: 100 * 1, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_4.id, ingredient_quantity: 100 * 3, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_4.id, ingredient_quantity: 100 * 1, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_4.id, ingredient_quantity: 100 * 2, measuring_unit: "g")

RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_5.id, ingredient_quantity: 100 * 2, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_5.id, ingredient_quantity: 100 * 1, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_5.id, ingredient_quantity: 100 * 3, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_5.id, ingredient_quantity: 100 * 1, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_5.id, ingredient_quantity: 100 * 2, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_5.id, ingredient_quantity: 100 * 3, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_5.id, ingredient_quantity: 100 * 1, measuring_unit: "g")
RecipeIngredient.create(ingredient_id: Ingredient.all.to_a.sample.id, recipe_id: recipe_5.id, ingredient_quantity: 100 * 2, measuring_unit: "g")

grocery_list = GroceryList.create(user_id: user.id, name: "Grocery List")

grocery_list.recipes << recipe_1
grocery_list.recipes << recipe_2
grocery_list.ingredients << recipe_1.ingredients
grocery_list.ingredients << recipe_2.ingredients

ScheduledRecipe.create(day: 'Monday', recipe_id: 3, user_id: 1)
ScheduledRecipe.create(day: 'Monday', recipe_id: 4, user_id: 1)
ScheduledRecipe.create(day: 'Monday', recipe_id: 1, user_id: 1)

ScheduledRecipe.create(day: 'Tuesday', recipe_id: 3, user_id: 1)
ScheduledRecipe.create(day: 'Tuesday', recipe_id: 2, user_id: 1)
ScheduledRecipe.create(day: 'Tuesday', recipe_id: 1, user_id: 1)

ScheduledRecipe.create(day: 'Wednesday', recipe_id: 3, user_id: 1)
ScheduledRecipe.create(day: 'Wednesday', recipe_id: 5, user_id: 1)
ScheduledRecipe.create(day: 'Wednesday', recipe_id: 4, user_id: 1)

ScheduledRecipe.create(day: 'Thursday', recipe_id: 3, user_id: 1)
ScheduledRecipe.create(day: 'Thursday', recipe_id: 4, user_id: 1)
ScheduledRecipe.create(day: 'Thursday', recipe_id: 2, user_id: 1)

ScheduledRecipe.create(day: 'Friday', recipe_id: 3, user_id: 1)
ScheduledRecipe.create(day: 'Friday', recipe_id: 5, user_id: 1)
ScheduledRecipe.create(day: 'Friday', recipe_id: 1, user_id: 1)

