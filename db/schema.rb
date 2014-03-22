# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140321181531) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collected_recipes", force: true do |t|
    t.integer  "recipe_id"
    t.integer  "collector_id"
    t.boolean  "favorite"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grocery_list_recipes", force: true do |t|
    t.integer "recipe_id"
    t.integer "grocery_list_id"
  end

  create_table "grocery_lists", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredients", force: true do |t|
    t.string   "name"
    t.string   "brand"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nutrition_informations", force: true do |t|
    t.integer  "ingredient_id"
    t.string   "brand_name"
    t.string   "item_name"
    t.string   "brand_id"
    t.string   "item_id"
    t.string   "upc"
    t.string   "item_type"
    t.string   "item_description"
    t.string   "nf_ingredient_statement"
    t.string   "nf_water_grams"
    t.string   "nf_calories"
    t.string   "nf_calories_from_fat"
    t.string   "nf_total_fat"
    t.string   "nf_saturated_fat"
    t.string   "nf_monounsaturated_fat"
    t.string   "nf_polyunsaturated_fat"
    t.string   "nf_trans_fatty_acid"
    t.string   "nf_cholesterol"
    t.string   "nf_sodium"
    t.string   "nf_total_carbohydrate"
    t.string   "nf_dietary_fiber"
    t.string   "nf_sugars"
    t.string   "nf_protein"
    t.string   "nf_vitamin_a_iu"
    t.string   "nf_vitamin_a_dv"
    t.string   "nf_vitamin_c_mg"
    t.string   "nf_vitamin_c_dv"
    t.string   "nf_calcium_mg"
    t.string   "nf_calcium_dv"
    t.string   "nf_iron_mg"
    t.string   "nf_iron_dv"
    t.string   "nf_refuse_pct"
    t.string   "nf_servings_per_container"
    t.string   "nf_serving_size_qty"
    t.string   "nf_serving_size_unit"
    t.string   "nf_serving_weight_grams"
    t.string   "allergen_contains_milk"
    t.string   "allergen_contains_eggs"
    t.string   "allergen_contains_fish"
    t.string   "allergen_contains_shellfish"
    t.string   "allergen_contains_tree_nuts"
    t.string   "allergen_contains_peanuts"
    t.string   "allergen_contains_wheat"
    t.string   "allergen_contains_soybeans"
    t.string   "allergen_contains_gluten"
    t.string   "nutrition_tags"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipe_ingredients", force: true do |t|
    t.integer  "ingredient_id"
    t.integer  "recipe_id"
    t.integer  "ingredient_quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipes", force: true do |t|
    t.integer  "creator_id"
    t.string   "name"
    t.text     "directions"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scheduled_recipes", force: true do |t|
    t.string   "day"
    t.integer  "recipe_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
