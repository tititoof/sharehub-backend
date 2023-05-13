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

ActiveRecord::Schema[7.0].define(version: 2023_05_10_044307) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "location_cities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "latitude"
    t.string "longitude"
    t.uuid "country_id", null: false
    t.uuid "state_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_location_cities_on_country_id"
    t.index ["state_id"], name: "index_location_cities_on_state_id"
  end

  create_table "location_countries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.string "emoji"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_location_countries_on_code", unique: true
  end

  create_table "location_states", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.uuid "country_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_location_states_on_country_id"
  end

  create_table "organizations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "kind"
    t.date "borned_at"
    t.string "address"
    t.string "phone_number"
    t.string "email_address"
    t.string "website"
    t.text "activity_description"
    t.string "activity_sector"
    t.float "annual_turnover"
    t.integer "number_of_employees"
    t.string "legal_status"
    t.string "registration_number"
    t.string "region"
    t.uuid "country_id", null: false
    t.uuid "city_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_organizations_on_city_id"
    t.index ["country_id"], name: "index_organizations_on_country_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "phone"
    t.string "email"
    t.date "date_of_birth"
    t.string "nickname"
    t.uuid "city_id"
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_users_profiles_on_city_id"
    t.index ["nickname"], name: "index_users_profiles_on_nickname", unique: true
    t.index ["user_id"], name: "index_users_profiles_on_user_id"
  end

  add_foreign_key "location_cities", "location_countries", column: "country_id"
  add_foreign_key "location_cities", "location_states", column: "state_id"
  add_foreign_key "location_states", "location_countries", column: "country_id"
  add_foreign_key "organizations", "location_cities", column: "city_id"
  add_foreign_key "organizations", "location_countries", column: "country_id"
  add_foreign_key "users_profiles", "location_cities", column: "city_id"
  add_foreign_key "users_profiles", "users"
end
