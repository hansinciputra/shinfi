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

ActiveRecord::Schema.define(version: 20151124035625) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventories", force: true do |t|
    t.string   "name"
    t.integer  "quantity"
    t.string   "meter"
    t.decimal  "weight",             precision: 6,  scale: 4
    t.decimal  "sellprice",          precision: 10, scale: 2
    t.string   "category"
    t.binary   "pic"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "inventory_orders", force: true do |t|
    t.integer "order_id"
    t.integer "inventory_id"
    t.integer "quantity"
  end

  add_index "inventory_orders", ["inventory_id"], name: "index_inventory_orders_on_inventory_id", using: :btree
  add_index "inventory_orders", ["order_id"], name: "index_inventory_orders_on_order_id", using: :btree

  create_table "order_pos", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.decimal  "total_price",     precision: 10, scale: 2
    t.integer  "customer_id"
    t.datetime "order_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "readyorpo"
    t.integer  "order_status_id"
    t.decimal  "payment",         precision: 10, scale: 2
    t.decimal  "ongkir",          precision: 10, scale: 2
    t.decimal  "discount",        precision: 10, scale: 2
  end

  add_index "orders", ["customer_id"], name: "index_orders_on_customer_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
  end

end
