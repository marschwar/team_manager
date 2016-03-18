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

ActiveRecord::Schema.define(version: 20160316215931) do

  create_table "contacts", force: :cascade do |t|
    t.integer  "player_id",   null: false
    t.string   "email",       null: false
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer  "team_id",    null: false
    t.string   "type",       null: false
    t.string   "name"
    t.date     "event_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participations", force: :cascade do |t|
    t.integer  "event_id",                     null: false
    t.integer  "player_id",                    null: false
    t.boolean  "participated", default: false, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "participations", ["event_id", "player_id"], name: "index_participations_on_event_id_and_player_id", unique: true

  create_table "players", force: :cascade do |t|
    t.integer  "team_id"
    t.string   "first_name",                null: false
    t.string   "last_name"
    t.date     "birthday"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "position"
    t.integer  "number"
    t.boolean  "active",     default: true, null: false
  end

  create_table "rental_equipments", force: :cascade do |t|
    t.integer  "player_id",   null: false
    t.string   "type",        null: false
    t.string   "brand"
    t.string   "size"
    t.date     "rental_date", null: false
    t.date     "return_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "team_equipments", force: :cascade do |t|
    t.integer  "team_id"
    t.string   "type"
    t.string   "size"
    t.integer  "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "year_from",  null: false
    t.integer  "year_until", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "common_name",                    null: false
    t.string   "social_id"
    t.string   "email"
    t.string   "role",          default: "user", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auth_provider"
  end

end
