# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2026_06_16_120126) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.bigint "review_session_id", null: false
    t.string "page_url"
    t.string "author_name"
    t.text "body"
    t.decimal "x_percent"
    t.decimal "y_percent"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "y_document"
    t.integer "viewport_width"
    t.integer "viewport_height"
    t.string "page_path"
    t.float "x_document"
    t.string "element_selector"
    t.float "x_element"
    t.float "y_element"
    t.boolean "resolved", default: false, null: false
    t.string "author_type", default: "client", null: false
    t.index ["review_session_id"], name: "index_comments_on_review_session_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "review_sessions", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.string "name"
    t.string "base_url"
    t.string "share_token"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["project_id"], name: "index_review_sessions_on_project_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
  end

  add_foreign_key "comments", "review_sessions"
  add_foreign_key "projects", "users"
  add_foreign_key "review_sessions", "projects"
end
