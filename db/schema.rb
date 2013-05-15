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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130421230465) do

  create_table "categories", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "compositions", :force => true do |t|
    t.integer  "rank"
    t.integer  "user_id"
    t.integer  "food_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "compositions", ["food_id"], :name => "index_compositions_on_food_id"
  add_index "compositions", ["user_id"], :name => "index_compositions_on_user_id"

  create_table "element_type_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "description"
  end

  create_table "elements", :force => true do |t|
    t.float    "amount",           :null => false
    t.integer  "composition_id",   :null => false
    t.integer  "elements_type_id", :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "elements", ["composition_id"], :name => "index_elements_on_composition_id"
  add_index "elements", ["elements_type_id"], :name => "index_elements_on_elements_type_id"

  create_table "elements_types", :force => true do |t|
    t.string   "name",                  :null => false
    t.text     "description"
    t.float    "GDA_man"
    t.float    "GDA_woman"
    t.float    "GDA_child"
    t.string   "unit"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "element_type_group_id"
  end

  add_index "elements_types", ["element_type_group_id"], :name => "index_elements_types_on_group_id"

  create_table "foods", :force => true do |t|
    t.string   "slovakname",                 :null => false
    t.string   "englishname"
    t.text     "description"
    t.integer  "user_id",                    :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "category_id",                :null => false
    t.integer  "rank",        :default => 1
  end

  add_index "foods", ["slovakname"], :name => "index_foods_on_slovakname"
  add_index "foods", ["user_id"], :name => "index_foods_on_user_id"

  create_table "foods_recipes", :force => true do |t|
    t.integer  "food_id"
    t.integer  "recipe_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "foods_recipes", ["food_id"], :name => "index_foods_recipes_on_food_id"
  add_index "foods_recipes", ["recipe_id"], :name => "index_foods_recipes_on_recipe_id"

  create_table "foods_types", :force => true do |t|
    t.integer  "food_id",    :null => false
    t.integer  "type_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "foods_types", ["food_id"], :name => "index_foods_types_on_food_id"
  add_index "foods_types", ["type_id"], :name => "index_foods_types_on_type_id"

  create_table "menus", :force => true do |t|
    t.integer  "food_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
    t.integer  "rank"
  end

  add_index "menus", ["food_id"], :name => "index_menus_on_food_id"

  create_table "menus_foods", :force => true do |t|
    t.integer  "menu_id",                     :null => false
    t.integer  "food_id",                     :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "amount",     :default => 100
  end

  add_index "menus_foods", ["food_id"], :name => "index_menus_foods_on_food_id"
  add_index "menus_foods", ["menu_id"], :name => "index_menus_foods_on_menu_id"

  create_table "pg_search_documents", :force => true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "recipes", :force => true do |t|
    t.string   "name",                      :null => false
    t.integer  "price",      :default => 0
    t.integer  "rank",       :default => 1
    t.time     "time"
    t.text     "manual"
    t.integer  "food_id",                   :null => false
    t.integer  "user_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "people",     :default => 1
  end

  add_index "recipes", ["food_id"], :name => "index_recipes_on_food_id"
  add_index "recipes", ["user_id"], :name => "index_recipes_on_user_id"

  create_table "types", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "types_categories", :force => true do |t|
    t.integer  "type_id",     :null => false
    t.integer  "category_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "types_categories", ["category_id"], :name => "index_types_categories_on_category_id"
  add_index "types_categories", ["type_id"], :name => "index_types_categories_on_type_id"

  create_table "users", :force => true do |t|
    t.string   "username",              :null => false
    t.string   "name"
    t.string   "surname"
    t.string   "password_digest"
    t.string   "address"
    t.integer  "rank"
    t.date     "dateOfBirth"
    t.string   "email"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "password"
    t.string   "password_confirmation"
    t.string   "remember_token"
    t.string   "gender"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "users_menus", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "menu_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "users_menus", ["menu_id"], :name => "index_users_menus_on_menu_id"
  add_index "users_menus", ["user_id"], :name => "index_users_menus_on_user_id"

  create_table "users_recipes", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "recipe_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "users_recipes", ["recipe_id"], :name => "index_users_recipes_on_recipe_id"
  add_index "users_recipes", ["user_id"], :name => "index_users_recipes_on_user_id"

  add_foreign_key "compositions", "foods", :name => "compositions_food_id_fk"
  add_foreign_key "compositions", "users", :name => "compositions_user_id_fk"

  add_foreign_key "elements", "compositions", :name => "elements_composition_id_fk"
  add_foreign_key "elements", "elements_types", :name => "elements_elements_type_id_fk"

  add_foreign_key "foods", "categories", :name => "foods_category_id_fk"
  add_foreign_key "foods", "users", :name => "foods_user_id_fk"

  add_foreign_key "foods_types", "foods", :name => "foods_types_food_id_fk"
  add_foreign_key "foods_types", "types", :name => "foods_types_type_id_fk"

  add_foreign_key "menus_foods", "foods", :name => "menus_foods_food_id_fk"
  add_foreign_key "menus_foods", "menus", :name => "menus_foods_menu_id_fk"

  add_foreign_key "recipes", "foods", :name => "recipes_food_id_fk"

  add_foreign_key "types_categories", "categories", :name => "types_categories_category_id_fk"
  add_foreign_key "types_categories", "types", :name => "types_categories_type_id_fk"

  add_foreign_key "users_menus", "menus", :name => "users_menus_menu_id_fk"
  add_foreign_key "users_menus", "users", :name => "users_menus_user_id_fk"

  add_foreign_key "users_recipes", "recipes", :name => "users_recipes_recipe_id_fk"
  add_foreign_key "users_recipes", "users", :name => "users_recipes_user_id_fk"

end
