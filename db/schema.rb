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

ActiveRecord::Schema.define(version: 20140507210705) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: true do |t|
    t.integer "organization_id"
    t.string  "address1"
    t.string  "address2"
    t.string  "state"
    t.string  "country"
    t.string  "zip"
    t.float   "latitude"
    t.float   "longitude"
  end

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

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "headline"
    t.text     "description"
    t.string   "hiring_url"
    t.boolean  "active"
    t.boolean  "approved"
    t.string   "startup_genome_slug"
    t.string   "url"
    t.datetime "founded"
    t.integer  "startup_genome_id"
  end

  add_index "organizations", ["slug"], name: "index_organizations_on_slug", unique: true, using: :btree

  create_table "user_auth_services", force: true do |t|
    t.integer "user_id"
    t.string  "uid"
    t.string  "service_type"
  end

  create_table "users", force: true do |t|
    t.string "email"
    t.string "name"
    t.string "image"
  end

end
