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

ActiveRecord::Schema.define(version: 20160401103902) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "brands", force: true do |t|
    t.string   "name"
    t.string   "brand_pic"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "compinfos", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "creator"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "infotype"
  end

  create_table "craft_orders", force: true do |t|
    t.integer  "order_id"
    t.integer  "craft_id"
    t.decimal  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "crafts", force: true do |t|
    t.string   "name"
    t.integer  "PriceDet_id"
    t.integer  "user_id"
    t.string   "category"
    t.string   "price_determinant"
    t.text     "prod_desc"
    t.integer  "brand_id"
    t.decimal  "quantity"
    t.string   "availability"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provinsi"
    t.string   "kota"
    t.string   "kodepos"
    t.string   "email"
    t.integer  "user_id"
    t.string   "signas"
    t.string   "phone2"
    t.string   "address2"
    t.string   "kecamatan"
    t.string   "kelurahan"
    t.string   "fb_contact"
    t.string   "insta_contact"
  end

  create_table "inventories", force: true do |t|
    t.string   "name"
    t.decimal  "quantity"
    t.string   "meter"
    t.decimal  "sellprice",  precision: 10, scale: 2
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "weight",     precision: 10, scale: 2
    t.string   "material"
    t.string   "link"
    t.string   "fabrictype"
    t.string   "satuan"
    t.string   "ukuran"
    t.string   "berat"
    t.string   "warna"
    t.string   "prodtype"
    t.integer  "brand_id"
  end

  create_table "inventory_orders", force: true do |t|
    t.integer "order_id"
    t.integer "inventory_id"
    t.decimal "quantity"
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
    t.string   "delvmethod"
    t.string   "url_id"
    t.uuid     "user_id"
    t.text     "cust_notes"
  end

  add_index "orders", ["customer_id"], name: "index_orders_on_customer_id", using: :btree

  create_table "posters", force: true do |t|
    t.string   "name"
    t.integer  "display"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.string   "mainposter"
    t.string   "subposter"
    t.string   "banner"
    t.string   "squareposter"
  end

  create_table "price_dets", force: true do |t|
    t.integer  "craft_id"
    t.string   "subject"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prodtypes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "product_images", force: true do |t|
    t.string   "name"
    t.integer  "inventory_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "prod_img"
    t.integer  "displaypic"
  end

  create_table "type_inventories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.string   "address"
    t.string   "address2"
    t.string   "phone"
    t.string   "phone2"
    t.string   "provinsi"
    t.string   "kota"
    t.string   "kodepos"
    t.date     "dateofbirth"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "profpic"
    t.string   "provider"
    t.string   "kecamatan"
    t.string   "kelurahan"
    t.string   "fb_contact"
    t.string   "insta_contact"
  end

end
