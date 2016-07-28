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

ActiveRecord::Schema.define(version: 20160726183605) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "auctions", force: :cascade do |t|
    t.integer  "seller_id"
    t.integer  "bid_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "auctions", ["bid_id"], name: "index_auctions_on_bid_id", using: :btree
  add_index "auctions", ["seller_id"], name: "index_auctions_on_seller_id", using: :btree

  create_table "bids", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.decimal  "bidded",     precision: 10, scale: 2, default: 0.0
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  add_index "bids", ["product_id"], name: "index_bids_on_product_id", using: :btree
  add_index "bids", ["user_id"], name: "index_bids_on_user_id", using: :btree

  create_table "line_items", force: :cascade do |t|
    t.integer  "quantity",   default: 1
    t.float    "price",      default: 0.0
    t.integer  "user_id"
    t.integer  "product_id"
    t.integer  "bid_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "line_items", ["bid_id"], name: "index_line_items_on_bid_id", using: :btree
  add_index "line_items", ["product_id"], name: "index_line_items_on_product_id", using: :btree
  add_index "line_items", ["user_id"], name: "index_line_items_on_user_id", using: :btree

  create_table "product_attachments", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.decimal  "minimum_bid",       precision: 10, scale: 2
    t.decimal  "maximum_bid",       precision: 10, scale: 2
    t.text     "description"
    t.string   "name"
    t.string   "category"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.integer  "user_id"
    t.integer  "bid_taking",                                 default: 1
    t.datetime "expiration"
    t.float    "minimum_increment",                          default: 1.0
  end

  create_table "sellers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sellers", ["product_id"], name: "index_sellers_on_product_id", using: :btree
  add_index "sellers", ["user_id"], name: "index_sellers_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "name"
    t.string   "username"
    t.boolean  "admin",                  default: false
    t.boolean  "seller",                 default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "line_items", "bids"
  add_foreign_key "line_items", "products"
  add_foreign_key "line_items", "users"
end
