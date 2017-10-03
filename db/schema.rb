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

ActiveRecord::Schema.define(version: 20161230151218) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "api_accesses", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "private_key", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookings", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.datetime "begins_at", null: false
    t.datetime "ends_at", null: false
    t.jsonb "payload"
    t.uuid "occupiable_id", null: false
    t.boolean "blocking", default: false
    t.string "public_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["begins_at"], name: "index_bookings_on_begins_at"
    t.index ["blocking"], name: "index_bookings_on_blocking"
    t.index ["ends_at"], name: "index_bookings_on_ends_at"
    t.index ["public_token"], name: "index_bookings_on_public_token"
  end

  create_table "occupiables", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "description"
    t.uuid "api_access_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "versions", id: :serial, force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

end
