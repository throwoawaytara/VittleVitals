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

ActiveRecord::Schema.define(version: 20140324135426) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collected_recipes", force: true do |t|
    t.integer  "recipe_id"
    t.integer  "collector_id"
    t.boolean  "favorite"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grocery_list_ingredients", force: true do |t|
    t.integer "ingredient_id"
    t.integer "grocery_list_id"
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nutrition_informations", force: true do |t|
    t.integer  "ingredient_id"
    t.string   "db_no"
    t.text     "name"
    t.float    "water"
    t.integer  "calories"
    t.float    "protein"
    t.float    "total_fat"
    t.float    "ash"
    t.float    "carbs"
    t.float    "fiber"
    t.float    "sugars"
    t.float    "calcium"
    t.float    "iron"
    t.float    "magnesium"
    t.float    "phosphorus"
    t.float    "potassium"
    t.float    "sodium"
    t.float    "zinc"
    t.float    "copper"
    t.float    "manganese"
    t.float    "selenium"
    t.float    "vit_c"
    t.float    "thiamin"
    t.float    "riboflavin"
    t.float    "niacin"
    t.float    "panto_acid"
    t.float    "vit_b6"
    t.float    "folate_total"
    t.float    "folic_acid"
    t.float    "food_folate"
    t.float    "folate_dfe"
    t.float    "choline_tot"
    t.float    "vit_b12"
    t.integer  "vit_a_iu"
    t.float    "vit_a_rae"
    t.float    "retinol"
    t.float    "alpha_carot"
    t.float    "beta_carot"
    t.float    "beta_crypt"
    t.float    "lycopene"
    t.float    "lut_zeaz"
    t.float    "vit_e"
    t.float    "vit_d_mcg"
    t.integer  "vivit_d_iu"
    t.float    "vit_k"
    t.float    "fa_sat"
    t.float    "fa_mono"
    t.float    "fa_poly"
    t.float    "cholestrl"
    t.float    "gram_weight_a"
    t.string   "gram_weight_unit_a"
    t.float    "gram_weight_b"
    t.string   "gram_weight_unit_b"
    t.float    "refuse_pc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nutrition_informations", ["ingredient_id"], name: "index_nutrition_informations_on_ingredient_id", using: :btree

  create_table "recipe_ingredients", force: true do |t|
    t.integer  "ingredient_id"
    t.integer  "recipe_id"
    t.integer  "ingredient_quantity"
    t.string   "measuring_unit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipes", force: true do |t|
    t.integer  "creator_id"
    t.string   "name"
    t.text     "directions"
    t.string   "img_path"
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
