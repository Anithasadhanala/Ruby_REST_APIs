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

ActiveRecord::Schema[7.1].define(version: 2024_06_12_181521) do
  create_table "addresses", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "state", null: false
    t.string "postal_code", null: false
    t.string "city", null: false
    t.string "landmark", null: false
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "carts", force: :cascade do |t|
    t.integer "buyer_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_deleted", default: false
    t.integer "quantity", default: 1
    t.index ["buyer_id"], name: "index_carts_on_buyer_id"
    t.index ["product_id"], name: "index_carts_on_product_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deliveries", force: :cascade do |t|
    t.integer "buyer_id", null: false
    t.integer "delivery_user_id", null: false
    t.integer "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_deliveries_on_buyer_id"
    t.index ["delivery_user_id"], name: "index_deliveries_on_delivery_user_id"
    t.index ["order_id"], name: "index_deliveries_on_order_id"
  end

  create_table "delivery_user_details", force: :cascade do |t|
    t.integer "delivery_user_id", null: false
    t.integer "delivery_vehicle_id", null: false
    t.decimal "salary", precision: 10, scale: 2, null: false
    t.string "area_covering", null: false
    t.text "remarks"
    t.string "vehicle_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["delivery_user_id"], name: "index_delivery_user_details_on_delivery_user_id"
    t.index ["delivery_vehicle_id"], name: "index_delivery_user_details_on_delivery_vehicle_id"
  end

  create_table "delivery_vehicles", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.float "load", null: false
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "buyer_id", null: false
    t.decimal "total_amount", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "transaction_id", null: false
    t.string "status", default: "pending", null: false
    t.index ["buyer_id"], name: "index_orders_on_buyer_id"
    t.index ["transaction_id"], name: "index_orders_on_transaction_id"
  end

  create_table "product_ratings", force: :cascade do |t|
    t.integer "buyer_id", null: false
    t.integer "product_id", null: false
    t.float "rating", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_product_ratings_on_buyer_id"
    t.index ["product_id"], name: "index_product_ratings_on_product_id"
  end

  create_table "product_reviews", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "buyer_id", null: false
    t.text "review"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_deleted", default: false
    t.index ["buyer_id"], name: "index_product_reviews_on_buyer_id"
    t.index ["product_id"], name: "index_product_reviews_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.integer "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.integer "avg_rating", default: 0, null: false
    t.integer "seller_id"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["seller_id"], name: "index_products_on_seller_id"
  end

  create_table "seller_details", force: :cascade do |t|
    t.integer "buyer_id", null: false
    t.string "store_name", null: false
    t.string "store_license", null: false
    t.string "work_phone", null: false
    t.float "avg_rating"
    t.boolean "is_active", default: true
    t.string "store_logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_seller_details_on_buyer_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "order_id", null: false
    t.boolean "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "payment_mode", null: false
    t.index ["order_id"], name: "index_transactions_on_order_id"
  end

  create_table "user_jwt_tokens", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "jwt_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_active", default: true
    t.index ["user_id"], name: "index_user_jwt_tokens_on_user_id"
  end

  create_table "user_payment_details", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "bank_name", null: false
    t.string "credit_card_number"
    t.string "debit_card_number", null: false
    t.boolean "is_active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bhim_upi"
    t.string "wallet_number"
    t.index ["user_id"], name: "index_user_payment_details_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.integer "phone", null: false
    t.integer "age"
    t.string "gender"
    t.boolean "flag", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "carts", "products"
  add_foreign_key "carts", "users", column: "buyer_id"
  add_foreign_key "deliveries", "orders"
  add_foreign_key "deliveries", "users", column: "buyer_id"
  add_foreign_key "deliveries", "users", column: "delivery_user_id"
  add_foreign_key "delivery_user_details", "delivery_vehicles"
  add_foreign_key "delivery_user_details", "users", column: "delivery_user_id"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "orders", "transactions"
  add_foreign_key "orders", "users", column: "buyer_id"
  add_foreign_key "product_ratings", "products"
  add_foreign_key "product_ratings", "users", column: "buyer_id"
  add_foreign_key "product_reviews", "products"
  add_foreign_key "product_reviews", "users", column: "buyer_id"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "users", column: "seller_id"
  add_foreign_key "seller_details", "users", column: "buyer_id"
  add_foreign_key "transactions", "orders"
  add_foreign_key "user_jwt_tokens", "users"
  add_foreign_key "user_payment_details", "users"
end
