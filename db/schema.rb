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

ActiveRecord::Schema[8.1].define(version: 2026_05_15_112610) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "cart_items", force: :cascade do |t|
    t.bigint "cart_id", null: false
    t.datetime "created_at", null: false
    t.bigint "product_id", null: false
    t.bigint "product_variant_id", null: false
    t.integer "quantity"
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["product_id"], name: "index_cart_items_on_product_id"
    t.index ["product_variant_id"], name: "index_cart_items_on_product_variant_id"
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "customer_id", null: false
    t.bigint "store_id", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_carts_on_customer_id"
    t.index ["store_id"], name: "index_carts_on_store_id"
  end

  create_table "collection_discounts", force: :cascade do |t|
    t.bigint "collection_id", null: false
    t.datetime "created_at", null: false
    t.bigint "discount_id", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_id"], name: "index_collection_discounts_on_collection_id"
    t.index ["discount_id"], name: "index_collection_discounts_on_discount_id"
  end

  create_table "collections", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.bigint "store_id", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_collections_on_store_id"
  end

  create_table "customers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.boolean "is_default", default: false
    t.integer "orders_count", default: 0, null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.bigint "store_id", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
    t.index ["store_id"], name: "index_customers_on_store_id"
  end

  create_table "discounts", force: :cascade do |t|
    t.boolean "auto_generate_code", default: false
    t.datetime "created_at", null: false
    t.string "discount_code"
    t.string "discount_method"
    t.string "discount_title"
    t.string "discount_type"
    t.datetime "end_date"
    t.boolean "limit_one_per_customer", default: false
    t.datetime "start_date"
    t.bigint "store_id", null: false
    t.datetime "updated_at", null: false
    t.decimal "value"
    t.string "value_type"
    t.index ["store_id"], name: "index_discounts_on_store_id"
  end

  create_table "draft_order_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "custom_title"
    t.bigint "draft_order_id", null: false
    t.decimal "price", precision: 10, scale: 2
    t.bigint "product_id"
    t.bigint "product_variant_id"
    t.integer "quantity", default: 1
    t.datetime "updated_at", null: false
    t.index ["draft_order_id"], name: "index_draft_order_items_on_draft_order_id"
  end

  create_table "draft_orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "customer_email"
    t.decimal "discount_amount", precision: 10, scale: 2, default: "0.0"
    t.decimal "shipping_price", precision: 10, scale: 2, default: "0.0"
    t.string "status", default: "open"
    t.bigint "store_id", null: false
    t.decimal "subtotal", precision: 10, scale: 2, default: "0.0"
    t.decimal "total_price", precision: 10, scale: 2, default: "0.0"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["store_id"], name: "index_draft_orders_on_store_id"
    t.index ["user_id"], name: "index_draft_orders_on_user_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "role", default: "member"
    t.bigint "store_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["store_id"], name: "index_memberships_on_store_id"
    t.index ["user_id", "store_id"], name: "index_memberships_on_user_id_and_store_id", unique: true
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "order_id", null: false
    t.decimal "price"
    t.bigint "product_id", null: false
    t.bigint "product_variant_id", null: false
    t.integer "quantity"
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
    t.index ["product_variant_id"], name: "index_order_items_on_product_variant_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "city"
    t.string "country"
    t.datetime "created_at", null: false
    t.bigint "customer_id", null: false
    t.string "email"
    t.string "first_name"
    t.string "fulfillment_status", default: "pending"
    t.string "last_name"
    t.string "order_status", default: "pending"
    t.string "payment_status", default: "pending"
    t.string "phone"
    t.string "postal_code"
    t.text "shipping_address"
    t.decimal "shipping_price"
    t.bigint "store_id", null: false
    t.string "stripe_session_id"
    t.decimal "subtotal"
    t.decimal "total_price"
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["store_id"], name: "index_orders_on_store_id"
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.string "currency"
    t.bigint "order_id", null: false
    t.string "payment_method"
    t.string "status"
    t.string "stripe_session_id"
    t.string "transaction_id"
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_payments_on_order_id"
  end

  create_table "product_collections", force: :cascade do |t|
    t.bigint "collection_id", null: false
    t.datetime "created_at", null: false
    t.bigint "product_id", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_id"], name: "index_product_collections_on_collection_id"
    t.index ["product_id"], name: "index_product_collections_on_product_id"
  end

  create_table "product_discounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "discount_id", null: false
    t.bigint "product_id", null: false
    t.datetime "updated_at", null: false
    t.index ["discount_id"], name: "index_product_discounts_on_discount_id"
    t.index ["product_id"], name: "index_product_discounts_on_product_id"
  end

  create_table "product_images", force: :cascade do |t|
    t.string "alt_text"
    t.datetime "created_at", null: false
    t.string "image_url"
    t.bigint "product_id", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_images_on_product_id"
  end

  create_table "product_variants", force: :cascade do |t|
    t.string "color"
    t.datetime "created_at", null: false
    t.decimal "price"
    t.bigint "product_id", null: false
    t.string "size"
    t.integer "stock_quantity"
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_variants_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.text "description"
    t.boolean "published_online_store", default: false
    t.boolean "published_pos", default: false
    t.string "slug"
    t.string "status", default: "draft"
    t.bigint "store_id", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["store_id", "slug"], name: "index_products_on_store_id_and_slug", unique: true
    t.index ["store_id"], name: "index_products_on_store_id"
  end

  create_table "refunds", force: :cascade do |t|
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.bigint "payment_id", null: false
    t.text "reason"
    t.datetime "updated_at", null: false
    t.index ["payment_id"], name: "index_refunds_on_payment_id"
  end

  create_table "segments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.string "rule_type"
    t.string "rule_value"
    t.datetime "updated_at", null: false
  end

  create_table "stores", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "currency", default: "PKR"
    t.string "domain"
    t.string "name"
    t.string "slug"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["slug"], name: "index_stores_on_slug", unique: true
    t.index ["user_id"], name: "index_stores_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "provider"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "role", default: "member"
    t.string "uid"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "product_variants"
  add_foreign_key "cart_items", "products"
  add_foreign_key "carts", "customers"
  add_foreign_key "carts", "stores"
  add_foreign_key "collection_discounts", "collections"
  add_foreign_key "collection_discounts", "discounts"
  add_foreign_key "collections", "stores"
  add_foreign_key "customers", "stores"
  add_foreign_key "discounts", "stores"
  add_foreign_key "draft_order_items", "draft_orders"
  add_foreign_key "draft_order_items", "product_variants"
  add_foreign_key "draft_order_items", "products"
  add_foreign_key "draft_orders", "stores"
  add_foreign_key "draft_orders", "users"
  add_foreign_key "memberships", "stores"
  add_foreign_key "memberships", "users"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "product_variants"
  add_foreign_key "order_items", "products"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "stores"
  add_foreign_key "payments", "orders"
  add_foreign_key "product_collections", "collections"
  add_foreign_key "product_collections", "products"
  add_foreign_key "product_discounts", "discounts"
  add_foreign_key "product_discounts", "products"
  add_foreign_key "product_images", "products"
  add_foreign_key "product_variants", "products"
  add_foreign_key "products", "stores"
  add_foreign_key "refunds", "payments"
  add_foreign_key "stores", "users"
end
