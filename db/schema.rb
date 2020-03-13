# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_13_223957) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "content_entries", force: :cascade do |t|
    t.bigint "content_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "data"
    t.datetime "published_at"
    t.string "slug"
    t.index ["content_type_id", "slug"], name: "index_content_entries_on_content_type_id_and_slug", unique: true
    t.index ["content_type_id"], name: "index_content_entries_on_content_type_id"
  end

  create_table "content_types", force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.jsonb "fields"
    t.string "plural"
    t.index ["workspace_id", "slug"], name: "index_content_types_on_workspace_id_and_slug", unique: true
    t.index ["workspace_id"], name: "index_content_types_on_workspace_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "session_token"
    t.index ["session_token"], name: "index_sessions_on_session_token", unique: true
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "workspaces", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["slug"], name: "index_workspaces_on_slug", unique: true
    t.index ["user_id"], name: "index_workspaces_on_user_id"
  end

  add_foreign_key "content_entries", "content_types"
  add_foreign_key "content_types", "workspaces"
  add_foreign_key "sessions", "users"
  add_foreign_key "workspaces", "users"
end
