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

ActiveRecord::Schema.define(version: 20150517114306) do

  create_table "allocations", force: :cascade do |t|
    t.integer  "member_id",  limit: 4
    t.integer  "project_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "allocations", ["member_id"], name: "index_allocations_on_member_id", using: :btree
  add_index "allocations", ["project_id"], name: "index_allocations_on_project_id", using: :btree

  create_table "leaves", force: :cascade do |t|
    t.date     "leave_date"
    t.integer  "member_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "leaves", ["member_id"], name: "index_leaves_on_member_id", using: :btree

  create_table "members", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.decimal  "deliver_rate",             precision: 10, scale: 3
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "details",    limit: 65535
    t.integer  "quarter_id", limit: 4
    t.integer  "points",     limit: 4
    t.integer  "priority",   limit: 4
    t.integer  "completion", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "projects", ["quarter_id"], name: "index_projects_on_quarter_id", using: :btree

  create_table "quarters", force: :cascade do |t|
    t.integer  "year",       limit: 4
    t.integer  "index",      limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_foreign_key "allocations", "members"
  add_foreign_key "allocations", "projects"
  add_foreign_key "leaves", "members"
  add_foreign_key "projects", "quarters"
end
