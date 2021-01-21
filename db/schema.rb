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

ActiveRecord::Schema.define(version: 2021_01_21_023457) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.integer "aqi"
    t.datetime "aqi_date"
    t.integer "pm25_forecast1"
    t.date "pm25_forecast1_date"
    t.integer "pm25_forecast2"
    t.date "pm25_forecast2_date"
    t.integer "pm25_forecast3"
    t.date "pm25_forecast3_date"
    t.integer "pm25_forecast4"
    t.date "pm25_forecast4_date"
    t.integer "pm25_forecast5"
    t.date "pm25_forecast5_date"
    t.integer "pm25_forecast6"
    t.date "pm25_forecast6_date"
    t.integer "pm25_forecast7"
    t.date "pm25_forecast7_date"
    t.integer "pm25_forecast8"
    t.date "pm25_forecast8_date"
    t.integer "pm25_forecast9"
    t.date "pm25_forecast9_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
