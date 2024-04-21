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

ActiveRecord::Schema.define(version: 2024_04_21_065329) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "expense_item_participants", force: :cascade do |t|
    t.bigint "expense_item_id", null: false
    t.bigint "user_id", null: false
    t.decimal "amount", precision: 15, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["expense_item_id"], name: "index_expense_item_participants_on_expense_item_id"
    t.index ["user_id"], name: "index_expense_item_participants_on_user_id"
  end

  create_table "expense_items", force: :cascade do |t|
    t.bigint "expense_id", null: false
    t.string "title"
    t.decimal "amount", precision: 15, scale: 2
    t.boolean "equally_shared", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["expense_id"], name: "index_expense_items_on_expense_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.string "title"
    t.text "desc"
    t.decimal "total_amount", precision: 15, scale: 2
    t.bigint "paid_by_id", null: false
    t.date "expense_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["paid_by_id"], name: "index_expenses_on_paid_by_id"
  end

  create_table "settlements", force: :cascade do |t|
    t.bigint "sender_id", null: false
    t.bigint "receiver_id", null: false
    t.decimal "amount", precision: 15, scale: 2
    t.string "status"
    t.text "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["receiver_id"], name: "index_settlements_on_receiver_id"
    t.index ["sender_id"], name: "index_settlements_on_sender_id"
  end

  create_table "user_connections", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "connection_id", null: false
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["connection_id"], name: "index_user_connections_on_connection_id"
    t.index ["user_id"], name: "index_user_connections_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "mobile_number"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "expense_item_participants", "expense_items"
  add_foreign_key "expense_item_participants", "users"
  add_foreign_key "expense_items", "expenses"
  add_foreign_key "expenses", "users", column: "paid_by_id"
  add_foreign_key "settlements", "users", column: "receiver_id"
  add_foreign_key "settlements", "users", column: "sender_id"
  add_foreign_key "user_connections", "users"
  add_foreign_key "user_connections", "users", column: "connection_id"
end
