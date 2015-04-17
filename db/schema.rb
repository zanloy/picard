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

ActiveRecord::Schema.define(version: 20150417224140) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "comment",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "environments", force: true do |t|
    t.string   "name",                    null: false
    t.string   "domain",     default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "log_items", force: true do |t|
    t.integer  "entered_by_id"
    t.integer  "poc_id"
    t.datetime "when"
    t.integer  "environment_id"
    t.string   "name",           null: false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "log_items", ["entered_by_id"], name: "index_log_items_on_entered_by_id", using: :btree
  add_index "log_items", ["environment_id"], name: "index_log_items_on_environment_id", using: :btree
  add_index "log_items", ["poc_id"], name: "index_log_items_on_poc_id", using: :btree

  create_table "servers", force: true do |t|
    t.string   "name"
    t.integer  "environment_id"
    t.string   "ip_address"
    t.string   "ports"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "servers", ["environment_id"], name: "index_servers_on_environment_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "log_item_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["log_item_id"], name: "index_taggings_on_log_item_id", using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "email"
    t.string   "hashed_password"
    t.string   "name",             default: ""
    t.boolean  "enabled",          default: false
    t.boolean  "admin",            default: false
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
