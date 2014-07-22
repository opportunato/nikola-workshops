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

ActiveRecord::Schema.define(version: 20140722125233) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "host_images", force: true do |t|
    t.string   "image",      null: false
    t.integer  "host_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hosts", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "workshop_id", null: false
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hosts", ["workshop_id"], name: "index_hosts_on_workshop_id", using: :btree

  create_table "workshop_images", force: true do |t|
    t.string   "image",       null: false
    t.integer  "workshop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workshop_videos", force: true do |t|
    t.string   "link",        null: false
    t.integer  "workshop_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "video_id"
    t.string   "player_link"
    t.string   "video_type"
  end

  create_table "workshops", force: true do |t|
    t.string   "title"
    t.string   "headline"
    t.text     "description"
    t.text     "program"
    t.integer  "price"
    t.string   "buy_link"
    t.date     "start_date",                   null: false
    t.date     "end_date",                     null: false
    t.boolean  "is_published", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_price_min", default: false
    t.string   "slug"
  end

  add_index "workshops", ["slug"], name: "index_workshops_on_slug", unique: true, using: :btree
  add_index "workshops", ["start_date"], name: "index_workshops_on_start_date", using: :btree

end
