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

ActiveRecord::Schema.define(version: 2022_11_19_220257) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.integer "player_id", null: false
    t.string "email"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone"
  end

  create_table "events", force: :cascade do |t|
    t.integer "team_id", null: false
    t.string "type", null: false
    t.string "name"
    t.date "event_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "member_statuses", force: :cascade do |t|
    t.integer "player_id", null: false
    t.boolean "rental_equipment", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participations", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "player_id", null: false
    t.boolean "participated", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id", "player_id"], name: "index_participations_on_event_id_and_player_id", unique: true
  end

  create_table "players", force: :cascade do |t|
    t.integer "team_id"
    t.string "first_name", null: false
    t.string "last_name"
    t.date "birthday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "position"
    t.integer "number"
    t.boolean "active", default: true, null: false
    t.string "pants_size"
    t.string "licence"
    t.text "note"
    t.string "place_of_birth"
    t.date "member_since"
  end

  create_table "rental_equipments", force: :cascade do |t|
    t.string "inventory_number", null: false
    t.string "brand"
    t.string "size"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "serial_number"
    t.index ["inventory_number"], name: "index_rental_equipments_on_inventory_number", unique: true
  end

  create_table "rentals", force: :cascade do |t|
    t.integer "player_id", null: false
    t.string "type", null: false
    t.string "brand"
    t.string "size"
    t.date "rental_date", null: false
    t.date "return_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "inventory_number"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "team_equipments", force: :cascade do |t|
    t.integer "team_id"
    t.string "type"
    t.string "size"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "count"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.integer "year_from", null: false
    t.integer "year_until", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "common_name", null: false
    t.string "social_id"
    t.string "email"
    t.string "role", default: "user", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "auth_provider"
  end

end
