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

ActiveRecord::Schema.define(version: 20180427171736) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calculations", id: :string, limit: 100, force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "uom_id", limit: 30
    t.decimal "charge", precision: 9, scale: 2
    t.decimal "puc", precision: 9, scale: 2
    t.decimal "min_weight", precision: 9, scale: 2
    t.decimal "mwc", precision: 9, scale: 2
    t.integer "status", limit: 2, default: 1
    t.integer "valuation", default: 0
    t.integer "tax", default: 0
    t.string "calculation_type", limit: 100, default: "cargo", null: false
    t.string "branch", default: ["master"], array: true
    t.string "id_from_branch", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_calculations", unique: true
  end

  create_table "clients", id: :string, limit: 100, force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "address"
    t.string "contact", limit: 30
    t.string "email"
    t.decimal "credit_limit", precision: 9, scale: 2, default: "0.0"
    t.string "discount_id"
    t.integer "status", limit: 2, default: 1, null: false
    t.string "branch", default: ["master"], array: true
    t.string "id_from_branch", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", id: :string, limit: 100, force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "status", limit: 2, default: 1
    t.string "branch", default: ["master"], array: true
    t.string "id_from_branch", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "discounts", id: :string, limit: 100, force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "discount_type"
    t.decimal "amount", precision: 9, scale: 2
    t.integer "status", limit: 2, default: 1
    t.string "branch", default: ["master"], array: true
    t.string "id_from_branch", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "documents", id: :string, limit: 100, force: :cascade do |t|
    t.string "ref_id", limit: 30
    t.string "client_id", limit: 30
    t.string "kind_id", limit: 30
    t.string "discount_id", limit: 30
    t.string "calculation_id", limit: 30
    t.string "source_id", limit: 30
    t.string "destination_id", limit: 30, null: false
    t.date "trans_date"
    t.string "description"
    t.string "doc_type", default: "rec", null: false
    t.integer "status1", limit: 2, default: 1
    t.integer "status2", limit: 2, default: 1
    t.string "origin_id", limit: 30
    t.decimal "total_amount", precision: 9, scale: 2
    t.string "shipper"
    t.string "released_to"
    t.date "released_date"
    t.text "custom_tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", id: :string, limit: 100, force: :cascade do |t|
    t.string "name", limit: 100
    t.string "position", limit: 100
    t.string "department", limit: 100
    t.string "contact", limit: 50
    t.string "email", limit: 30
    t.integer "status", limit: 2, default: 1
    t.string "branch", default: ["master"], array: true
    t.string "id_from_branch", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kinds", id: :string, limit: 100, force: :cascade do |t|
    t.string "name", null: false
    t.integer "status", limit: 2, default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "charge", precision: 9, scale: 2, null: false
    t.decimal "puc", precision: 9, scale: 2, null: false
    t.string "branch", default: ["master"], array: true
    t.string "id_from_branch", default: [], array: true
  end

  create_table "locations", id: :string, limit: 100, force: :cascade do |t|
    t.string "company_id"
    t.string "name", limit: 100
    t.string "description"
    t.string "location_type", limit: 50
    t.integer "status", limit: 2, default: 1
    t.string "branch", default: ["master"], array: true
    t.string "id_from_branch", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_locations_on_name", unique: true
  end

  create_table "uoms", id: :string, limit: 100, force: :cascade do |t|
    t.string "measurement", null: false
    t.string "description"
    t.integer "status", limit: 2, default: 1
    t.string "branch", default: ["master"], array: true
    t.string "id_from_branch", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["measurement"], name: "index_uoms_on_measurement", unique: true
  end

  create_table "vehicles", id: :string, limit: 100, force: :cascade do |t|
    t.string "ref_id", null: false
    t.string "description"
    t.string "vehicle_type"
    t.integer "status", limit: 2, default: 1
    t.string "branch", default: ["master"], array: true
    t.string "id_from_branch", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
