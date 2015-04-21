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

ActiveRecord::Schema.define(version: 20150421144006) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id",               null: false
    t.string   "commentable_type", limit: 255, null: false
    t.integer  "user_id",                      null: false
    t.text     "comment",                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "environments", force: :cascade do |t|
    t.string   "name",       limit: 255,              null: false
    t.string   "domain",     limit: 255, default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "log_items", force: :cascade do |t|
    t.integer  "entered_by_id"
    t.integer  "poc_id"
    t.datetime "when"
    t.integer  "environment_id"
    t.string   "name",           limit: 255, null: false
    t.string   "description",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "log_items", ["entered_by_id"], name: "index_log_items_on_entered_by_id", using: :btree
  add_index "log_items", ["environment_id"], name: "index_log_items_on_environment_id", using: :btree
  add_index "log_items", ["poc_id"], name: "index_log_items_on_poc_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "address",             limit: 255
    t.string   "company",             limit: 255
    t.string   "phone",               limit: 255
    t.string   "alternative_contact", limit: 255
    t.string   "im_address",          limit: 255
    t.string   "va_email",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "servers", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "environment_id"
    t.string   "ip_address",     limit: 255
    t.string   "ports",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "servers", ["environment_id"], name: "index_servers_on_environment_id", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "subscribable_id",               null: false
    t.string   "subscribable_type", limit: 255, null: false
    t.integer  "user_id",                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["subscribable_id", "subscribable_type"], name: "index_subscriptions_on_subscribable_id_and_subscribable_type", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "log_item_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["log_item_id"], name: "index_taggings_on_log_item_id", using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_details", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "address",             limit: 255
    t.string   "company",             limit: 255
    t.string   "phone",               limit: 255
    t.string   "alternative_contact", limit: 255
    t.string   "im_address",          limit: 255
    t.string   "va_email",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_details", ["user_id"], name: "index_user_details_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider",         limit: 255
    t.string   "uid",              limit: 255
    t.string   "email",            limit: 255
    t.string   "hashed_password",  limit: 255
    t.string   "name",             limit: 255, default: ""
    t.boolean  "enabled",                      default: false
    t.boolean  "admin",                        default: false
    t.string   "oauth_token",      limit: 255
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
