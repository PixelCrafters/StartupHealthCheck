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

ActiveRecord::Schema.define(version: 20140603212059) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "addresses", force: true do |t|
    t.integer "organization_id"
    t.string  "address1"
    t.string  "address2"
    t.string  "state"
    t.string  "country"
    t.string  "zip"
    t.float   "latitude"
    t.float   "longitude"
    t.string  "city"
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

  create_table "organization_user_roles", force: true do |t|
    t.integer "organization_id"
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "organization_user_roles", ["organization_id", "role_id", "user_id"], name: "organization_role_users_index", unique: true, using: :btree

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
    t.boolean  "claimed",             default: false
    t.boolean  "hiring",              default: false
  end

  add_index "organizations", ["slug"], name: "index_organizations_on_slug", unique: true, using: :btree

  create_table "organizations_types", id: false, force: true do |t|
    t.integer "organization_id"
    t.integer "type_id"
  end

  add_index "organizations_types", ["organization_id", "type_id"], name: "index_organizations_types_on_organization_id_and_type_id", unique: true, using: :btree

  create_table "organizations_users", id: false, force: true do |t|
    t.integer "organization_id"
    t.integer "user_id"
  end

  create_table "profile_links", force: true do |t|
    t.string  "url"
    t.integer "organization_id"
    t.string  "image"
    t.string  "name"
  end

  create_table "roles", force: true do |t|
    t.string "name"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "types", force: true do |t|
    t.string "name"
  end

  create_table "user_auth_services", force: true do |t|
    t.integer "user_id"
    t.string  "uid"
    t.string  "service_type"
  end

  add_index "user_auth_services", ["uid"], name: "index_user_auth_services_on_uid", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string  "email"
    t.string  "name"
    t.string  "image"
    t.boolean "email_verified", default: false
  end

end
