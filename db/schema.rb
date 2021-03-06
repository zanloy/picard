# encoding: UTF-8
# frozen_string_literal: true
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

ActiveRecord::Schema.define(version: 20150922114709) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alerts", force: :cascade do |t|
    t.integer  "list_id"
    t.string   "field"
    t.string   "operator"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "alerts", ["list_id"], name: "index_alerts_on_list_id", using: :btree

  create_table "attachments", force: :cascade do |t|
    t.integer  "engineering_change_id"
    t.integer  "reference",             default: 0
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "attachments", ["engineering_change_id"], name: "index_attachments_on_engineering_change_id", using: :btree

  create_table "certificate_locations", force: :cascade do |t|
    t.integer  "server_id"
    t.integer  "certificate_id"
    t.string   "location"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "certificate_locations", ["certificate_id"], name: "index_certificate_locations_on_certificate_id", using: :btree
  add_index "certificate_locations", ["server_id"], name: "index_certificate_locations_on_server_id", using: :btree

  create_table "certificates", force: :cascade do |t|
    t.string   "subject"
    t.string   "cn"
    t.string   "issuer"
    t.datetime "not_before"
    t.datetime "not_after"
    t.string   "signature_algorithm"
    t.integer  "key_length"
    t.string   "modulus"
    t.text     "pem",                             null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "locations_count",     default: 0
    t.string   "poc"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id",   null: false
    t.string   "commentable_type", null: false
    t.integer  "user_id",          null: false
    t.text     "comment",          null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "crono_jobs", force: :cascade do |t|
    t.string   "job_id",            null: false
    t.text     "log"
    t.datetime "last_performed_at"
    t.boolean  "healthy"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "crono_jobs", ["job_id"], name: "index_crono_jobs_on_job_id", unique: true, using: :btree

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

  create_table "engineering_changes", force: :cascade do |t|
    t.integer  "entered_by_id"
    t.integer  "poc_id"
    t.datetime "when"
    t.integer  "environment_id"
    t.string   "title",          null: false
    t.text     "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "engineering_changes", ["entered_by_id"], name: "index_engineering_changes_on_entered_by_id", using: :btree
  add_index "engineering_changes", ["environment_id"], name: "index_engineering_changes_on_environment_id", using: :btree
  add_index "engineering_changes", ["poc_id"], name: "index_engineering_changes_on_poc_id", using: :btree

  create_table "environments", force: :cascade do |t|
    t.string   "name",                    null: false
    t.string   "domain",     default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "shortname"
  end

  add_index "environments", ["name"], name: "index_environments_on_name", using: :btree

  create_table "list_items", force: :cascade do |t|
    t.integer  "list_id"
    t.text     "payload"
    t.integer  "updated_by_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "list_items", ["list_id"], name: "index_list_items_on_list_id", using: :btree

  create_table "lists", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.text     "schema"
    t.integer  "list_items_count"
    t.integer  "last_added_by_id"
    t.date     "last_added_on"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "on_new_change", default: false, null: false
    t.boolean  "on_new_event",  default: false, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "on_new_user",   default: false, null: false
  end

  add_index "notifications", ["on_new_change"], name: "index_notifications_on_on_new_change", using: :btree
  add_index "notifications", ["on_new_event"], name: "index_notifications_on_on_new_event", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "apikey"
    t.string   "address"
    t.string   "company"
    t.string   "phone"
    t.string   "alternative_contact"
    t.string   "im_address"
    t.string   "va_email"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "slack_username"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "servers", force: :cascade do |t|
    t.string   "name",           null: false
    t.integer  "environment_id"
    t.string   "ip_address"
    t.string   "ports"
    t.string   "api_key"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "servers", ["api_key"], name: "index_servers_on_api_key", using: :btree
  add_index "servers", ["environment_id"], name: "index_servers_on_environment_id", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "subscribable_id",   null: false
    t.string   "subscribable_type", null: false
    t.integer  "user_id",           null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "subscriptions", ["subscribable_type", "subscribable_id"], name: "index_subscriptions_on_subscribable_type_and_subscribable_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "taggable_id",   null: false
    t.string   "taggable_type", null: false
    t.integer  "tag_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "email",                               null: false
    t.string   "hashed_password"
    t.string   "name",                default: ""
    t.boolean  "enabled",             default: false
    t.boolean  "admin",               default: false
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "banned",              default: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

  add_foreign_key "alerts", "lists"
  add_foreign_key "attachments", "engineering_changes"
  add_foreign_key "certificate_locations", "certificates"
  add_foreign_key "certificate_locations", "servers"
  add_foreign_key "engineering_changes", "environments"
  add_foreign_key "list_items", "lists"
  add_foreign_key "notifications", "users"
  add_foreign_key "servers", "environments"
end
