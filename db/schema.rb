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

ActiveRecord::Schema.define(version: 20151002095408) do

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
    t.string   "pName"
    t.integer  "pQuantity"
    t.string   "pMeter"
    t.decimal  "pWeight",            precision: 6,  scale: 4
    t.decimal  "pSellPrice",         precision: 10, scale: 2
    t.string   "pCategory"
    t.binary   "pPic"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "inventory_orders", id: false, force: true do |t|
    t.integer "orders_id"
    t.integer "inventories_id"
  end

  add_index "inventory_orders", ["inventories_id"], name: "index_inventory_orders_on_inventories_id", using: :btree
  add_index "inventory_orders", ["orders_id"], name: "index_inventory_orders_on_orders_id", using: :btree

  create_table "orders", force: true do |t|
    t.decimal  "total_price", precision: 10, scale: 2
    t.integer  "customer_id"
    t.datetime "order_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["customer_id"], name: "index_orders_on_customer_id", using: :btree

end
