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

ActiveRecord::Schema.define(version: 20160724183940) do

  create_table "car_marks", force: :cascade do |t|
    t.string   "name"
    t.string   "fipe_name"
    t.string   "fipe_key"
    t.integer  "fipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "car_model_years", force: :cascade do |t|
    t.string   "name"
    t.string   "fipe_key"
    t.integer  "car_model_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "car_model_years", ["car_model_id"], name: "index_car_model_years_on_car_model_id"

  create_table "car_models", force: :cascade do |t|
    t.string   "name"
    t.string   "fipe_name"
    t.string   "fipe_key"
    t.integer  "fipe_id"
    t.integer  "car_mark_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "car_models", ["car_mark_id"], name: "index_car_models_on_car_mark_id"

  create_table "vehicle_prices", force: :cascade do |t|
    t.string   "name"
    t.string   "mark"
    t.string   "year_model"
    t.string   "price"
    t.string   "fuel"
    t.string   "reference"
    t.integer  "car_model_year_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "vehicle_prices", ["car_model_year_id"], name: "index_vehicle_prices_on_car_model_year_id"

end
