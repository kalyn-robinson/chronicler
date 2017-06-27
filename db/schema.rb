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

ActiveRecord::Schema.define(version: 20170626203808) do

  create_table "character_sheets", force: :cascade do |t|
    t.text "properties"
    t.integer "character_id"
    t.integer "sheet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_character_sheets_on_character_id"
    t.index ["sheet_id"], name: "index_character_sheets_on_sheet_id"
  end

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "user_id", "created_at", "updated_at", "deleted_at"], name: "index_characters"
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "sheets", force: :cascade do |t|
    t.string "name"
    t.text "properties"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "remember_digest"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.boolean "admin"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["name"], name: "index_users_on_name", unique: true, where: "deleted_at IS NULL"
  end

end
