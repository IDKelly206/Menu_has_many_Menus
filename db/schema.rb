# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_02_29_152444) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.bigint "meal_id", null: false
    t.string "course_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "erecipe_id", null: false
    t.index ["meal_id"], name: "index_courses_on_meal_id"
  end

  create_table "dietary_restrictions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "health_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["health_id"], name: "index_dietary_restrictions_on_health_id"
    t.index ["user_id", "health_id"], name: "index_dietary_restrictions_on_user_id_and_health_id", unique: true
    t.index ["user_id"], name: "index_dietary_restrictions_on_user_id"
  end

  create_table "groceries", force: :cascade do |t|
    t.string "name", null: false
    t.float "quantity", null: false
    t.string "measurement", null: false
    t.string "category"
    t.string "erecipe_id", null: false
    t.bigint "household_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "list_add", default: true, null: false
    t.bigint "course_id", null: false
    t.index ["course_id"], name: "index_groceries_on_course_id"
    t.index ["household_id"], name: "index_groceries_on_household_id"
  end

  create_table "healths", force: :cascade do |t|
    t.string "parameter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "households", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meals", force: :cascade do |t|
    t.string "meal_type"
    t.bigint "menu_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_meals_on_menu_id"
    t.index ["user_id"], name: "index_meals_on_user_id"
  end

  create_table "menus", force: :cascade do |t|
    t.date "date"
    t.bigint "household_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["household_id"], name: "index_menus_on_household_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "brand"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "kproduct_id", null: false
    t.string "upc"
    t.jsonb "item_info", default: {}
    t.string "aisle", default: [], array: true
    t.jsonb "images", default: {}
  end

  create_table "recipes", force: :cascade do |t|
    t.string "label"
    t.string "source"
    t.integer "yield"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "erecipe_id"
    t.string "image"
    t.jsonb "ingredients", default: {}
    t.jsonb "images", default: {}
    t.string "source_url"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "household_id", null: false
    t.string "name_first"
    t.string "name_last"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["household_id"], name: "index_users_on_household_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "courses", "meals"
  add_foreign_key "dietary_restrictions", "healths"
  add_foreign_key "dietary_restrictions", "users"
  add_foreign_key "groceries", "courses"
  add_foreign_key "groceries", "households"
  add_foreign_key "meals", "menus"
  add_foreign_key "meals", "users"
  add_foreign_key "menus", "households"
  add_foreign_key "users", "households"
end
