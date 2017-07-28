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

ActiveRecord::Schema.define(version: 20170728160614) do

  create_table "addresses", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "country"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "brands", force: :cascade do |t|
    t.integer  "seller_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string   "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "dish_id"
    t.string   "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dishes", force: :cascade do |t|
    t.integer  "kitchen_id"
    t.integer  "preparation_time"
    t.integer  "price"
    t.string   "name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "dishes_tags", force: :cascade do |t|
    t.integer  "dish_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evaluations", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "dish_id"
    t.integer  "calification"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "kitchens", force: :cascade do |t|
    t.integer  "seller_id"
    t.integer  "brand_id"
    t.string   "name"
    t.string   "address"
    t.string   "zone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_details", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "dish_id"
    t.integer  "price"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "total_amount"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "name"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "country"
    t.string   "card_number"
    t.string   "security_code"
    t.string   "expiry_date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "sellers", force: :cascade do |t|
    t.integer  "user_id"
<<<<<<< HEAD
    t.integer  "id_branch_office"
    t.string   "RFC"
    t.string   "CLABE"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
=======
    t.integer  "kitchen_id"
    t.integer  "brand_id"
    t.string   "RFC"
    t.string   "CLABE"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
>>>>>>> 6ad289e9feb1633a568b0ce78f157ee1c4aa8875
<<<<<<< HEAD
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
=======
>>>>>>> 8f29343e2d9860008be59252c62fff3bb4e01cad
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.string   "last_name"
    t.string   "cellphone"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

end
