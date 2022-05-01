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

ActiveRecord::Schema[7.0].define(version: 2022_04_30_183421) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "face_accounts", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "farm_links", force: :cascade do |t|
    t.string "href"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "farmed"
    t.integer "origin"
    t.string "product_title"
    t.boolean "fail"
  end

  create_table "wibx_accounts", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wibx_products", force: :cascade do |t|
    t.string "title"
    t.integer "facebook_link"
    t.integer "whatsapp_link"
    t.integer "telegram_link"
    t.float "facebook_gain"
    t.float "whatsapp_gain"
    t.float "telegram_gain"
    t.integer "facebook_requests"
    t.integer "whatsapp_requests"
    t.integer "telegram_requests"
    t.float "total_user_product_gain"
    t.float "user_facebook_gain"
    t.float "user_whatsapp_gain"
    t.float "user_telegram_gain"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
