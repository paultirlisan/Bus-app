# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_27_111734) do

  create_table "average_caches", force: :cascade do |t|
    t.integer "rater_id"
    t.string "rateable_type"
    t.integer "rateable_id"
    t.float "avg", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rateable_type", "rateable_id"], name: "index_average_caches_on_rateable_type_and_rateable_id"
    t.index ["rater_id"], name: "index_average_caches_on_rater_id"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "data_fingerprint"
    t.string "type", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "companies", force: :cascade do |t|
    t.integer "user_id"
    t.text "description"
    t.string "phone"
    t.string "headquarters"
    t.text "careers_advertisement"
    t.boolean "active", default: true
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "journeys", force: :cascade do |t|
    t.integer "user_id"
    t.integer "route_id"
    t.datetime "date"
    t.index ["route_id", "date"], name: "index_journeys_on_route_id_and_date"
    t.index ["user_id"], name: "index_journeys_on_user_id"
  end

  create_table "overall_averages", force: :cascade do |t|
    t.string "rateable_type"
    t.integer "rateable_id"
    t.float "overall_avg", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rateable_type", "rateable_id"], name: "index_overall_averages_on_rateable_type_and_rateable_id"
  end

  create_table "rates", force: :cascade do |t|
    t.integer "rater_id"
    t.string "rateable_type"
    t.integer "rateable_id"
    t.float "stars", null: false
    t.string "dimension"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type"
    t.index ["rateable_type", "rateable_id"], name: "index_rates_on_rateable_type_and_rateable_id"
    t.index ["rater_id"], name: "index_rates_on_rater_id"
  end

  create_table "rating_caches", force: :cascade do |t|
    t.string "cacheable_type"
    t.integer "cacheable_id"
    t.float "avg", null: false
    t.integer "qty", null: false
    t.string "dimension"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type"
    t.index ["cacheable_type", "cacheable_id"], name: "index_rating_caches_on_cacheable_type_and_cacheable_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "user_id"
    t.integer "company_id"
    t.integer "rating"
    t.string "body"
    t.index ["company_id"], name: "index_reviews_on_company_id"
    t.index ["user_id", "company_id"], name: "index_reviews_on_user_id_and_company_id", unique: true
  end

  create_table "routes", force: :cascade do |t|
    t.integer "company_id"
    t.integer "departure_station_id"
    t.integer "arrival_station_id"
    t.string "name"
    t.integer "duration"
    t.float "distance"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "period"
    t.float "price"
    t.integer "capacity"
    t.index ["company_id"], name: "first_index"
    t.index ["departure_station_id", "arrival_station_id", "company_id"], name: "sixth_index"
    t.index ["departure_station_id", "arrival_station_id", "duration", "company_id"], name: "seventh_index"
    t.index ["departure_station_id", "arrival_station_id", "duration", "price", "company_id"], name: "ninth_index"
    t.index ["departure_station_id", "arrival_station_id", "duration", "price"], name: "fifth_index"
    t.index ["departure_station_id", "arrival_station_id", "duration"], name: "third_index"
    t.index ["departure_station_id", "arrival_station_id", "name"], name: "tenth_index", unique: true
    t.index ["departure_station_id", "arrival_station_id", "price", "company_id"], name: "eigth_index"
    t.index ["departure_station_id", "arrival_station_id", "price"], name: "fourth_index"
    t.index ["departure_station_id", "arrival_station_id"], name: "second_index"
  end

  create_table "stations", force: :cascade do |t|
    t.integer "company_id"
    t.string "name"
    t.string "city"
    t.index ["city"], name: "index_stations_on_city"
    t.index ["company_id", "name", "city"], name: "index_stations_on_company_id_and_name_and_city", unique: true
    t.index ["company_id"], name: "index_stations_on_company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
