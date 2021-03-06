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

ActiveRecord::Schema.define(version: 20170128005201) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "environments", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "version"
    t.string   "region",      null: false
    t.string   "bucket_name", null: false
    t.integer  "project_id",  null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["project_id"], name: "index_environments_on_project_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "bucket_name", null: false
    t.string   "region",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["bucket_name"], name: "index_projects_on_bucket_name", unique: true, using: :btree
    t.index ["name"], name: "index_projects_on_name", unique: true, using: :btree
  end

  create_table "replaces", force: :cascade do |t|
    t.string   "file",           null: false
    t.string   "key",            null: false
    t.string   "value",          null: false
    t.integer  "environment_id", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["environment_id"], name: "index_replaces_on_environment_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.string   "name",       null: false
    t.string   "logo",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "environments", "projects"
  add_foreign_key "replaces", "environments"
end
