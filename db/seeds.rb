#encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

recipe_1 = Recipe.create(name: 'Mac & Cheese', directions: "Cook macaroni according to the package directions. Drain. In a saucepan, melt butter or margarine over medium heat. Stir in enough flour to make a roux. Add milk to roux slowly, stirring constantly. Stir in cheeses, and cook over low heat until cheese is melted and the sauce is a little thick. Put macaroni in large casserole dish, and pour sauce over macaroni. Stir well. Melt butter or margarine in a skillet over medium heat. Add breadcrumbs and brown. Spread over the macaroni and cheese to cover. Sprinkle with a little paprika. Bake at 350 degrees F for 30 minutes. Serve.")

recipe_2 = Recipe.create(name: 'Ramen Noodle Salads', directions: "A tasty broccoli and ramen noodle salad requires two packages of raw broken ramen noodles, a 16-ounce package of broccoli slaw mix, a bunch of green onions chopped, and a cup each of unsalted peanuts and sunflower seeds. Mix these ingredients and pour over a dressing of cup vegetable oil, 1/3 cup cider vinegar, cup white sugar, and 1 seasoning packet. A squirt of lime juice and some chopped cilantro can also be added.")

recipe_3 = Recipe.create(name: 'Tofu Scramble', directions: "Preheat a large, heavy bottomed pan over medium high heat. Saute the garlic in olive oil for about a minute. Break the tofu apart into bite sized pieces and saute for about 10 minutes, using a spatula to stir often. Get under the tofu when you are stirring, scrape the bottom and don’t let it stick to the pan, that is where the good, crispy stuff is. Use a thin metal spatula to get the job done, a wooden or plastic one won’t really cut it. The tofu should get browned on at least one side, but you don’t need to be too precise about it. The water should cook out of it and not collect too much at the bottom of the ban. If that is happening, turn the heat up and let the water evaporate. Add the spice blend and mix to incorporate. Add the nutritional yeast and fresh black pepper. Cook for about 5 more minutes. Serve warm.")

recipe_1.ingredients.create
