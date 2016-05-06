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

ActiveRecord::Schema.define(version: 20160506125926) do

  create_table "items", force: :cascade do |t|
    t.string   "code"
    t.float    "unit_price"
    t.float    "volume_price"
    t.integer  "volume_qty"
    t.integer  "terminal_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "items", ["terminal_id"], name: "index_items_on_terminal_id"

  create_table "scan_items", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "shopping_cart_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "scan_items", ["item_id"], name: "index_scan_items_on_item_id"
  add_index "scan_items", ["shopping_cart_id"], name: "index_scan_items_on_shopping_cart_id"

  create_table "shopping_carts", force: :cascade do |t|
    t.integer  "terminal_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "shopping_carts", ["terminal_id"], name: "index_shopping_carts_on_terminal_id"

  create_table "terminals", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
