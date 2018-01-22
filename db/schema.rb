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

ActiveRecord::Schema.define(version: 20161206230108) do

  create_table "bookings", force: :cascade do |t|
    t.integer  "room_id"
    t.date     "start",      null: false
    t.date     "end",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_bookings_on_room_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.integer  "number",                        null: false
    t.string   "name"
    t.string   "size",       default: "single", null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

end
