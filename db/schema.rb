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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110810042047) do

  create_table "business_deals", :force => true do |t|
    t.string   "name"
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "business_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "business_types", ["id"], :name => "index_business_types_on_id"

  create_table "carts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "unique_identifier", :null => false
    t.text     "products"
    t.text     "order_options"
  end

  add_index "carts", ["unique_identifier"], :name => "index_carts_on_unique_identifier"

  create_table "catalogs", :force => true do |t|
    t.integer  "user_id",                            :null => false
    t.string   "company_name",                       :null => false
    t.integer  "businesstype_id",                    :null => false
    t.integer  "location_id",                        :null => false
    t.string   "phone",                              :null => false
    t.string   "email",                              :null => false
    t.string   "company_url"
    t.string   "tariff",                             :null => false
    t.integer  "rating",              :default => 0, :null => false
    t.text     "company_description"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shortcut_name"
    t.string   "lat"
    t.string   "lng"
    t.text     "business_deals"
    t.text     "zakaz_phraze"
    t.string   "zakaz_layout"
    t.text     "filter_params"
    t.text     "order_statuses"
    t.string   "address"
  end

  add_index "catalogs", ["businesstype_id"], :name => "index_catalogs_on_businesstype_id"
  add_index "catalogs", ["id"], :name => "index_catalogs_on_id"
  add_index "catalogs", ["location_id"], :name => "index_catalogs_on_location_id"
  add_index "catalogs", ["shortcut_name"], :name => "index_catalogs_on_shortcut_name"
  add_index "catalogs", ["user_id"], :name => "index_catalogs_on_user_id"

  create_table "izbrannoes", :force => true do |t|
    t.string   "identificator"
    t.integer  "catalog_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "link"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "vid"
    t.string   "domain"
  end

  add_index "locations", ["id"], :name => "index_locations_on_id"

  create_table "orders", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "catalog_id",     :null => false
    t.string   "customer_id",    :null => false
    t.text     "products",       :null => false
    t.text     "payment",        :null => false
    t.text     "delivery",       :null => false
    t.text     "state",          :null => false
    t.string   "customer_phone"
    t.string   "customer_email"
    t.string   "agreement"
    t.string   "last_status"
  end

  add_index "orders", ["catalog_id"], :name => "index_orders_on_catalog_id"
  add_index "orders", ["customer_id"], :name => "index_orders_on_customer_id"
  add_index "orders", ["id"], :name => "index_orders_on_id"
  add_index "orders", ["last_status"], :name => "index_orders_on_last_status"

  create_table "pictures", :force => true do |t|
    t.integer  "user_id",              :null => false
    t.integer  "catalog_id",           :null => false
    t.text     "description"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_pictures", :force => true do |t|
    t.integer  "user_id",              :null => false
    t.integer  "catalog_id",           :null => false
    t.integer  "product_id",           :null => false
    t.string   "note"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.integer  "catalog_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "price_notation"
    t.integer  "price"
    t.integer  "user_id",        :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["id"], :name => "index_sessions_on_id"
  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "signups", :force => true do |t|
    t.string   "session_id"
    t.string   "bestpic_comment"
    t.string   "company_name"
    t.integer  "businesstype_id"
    t.integer  "location_id"
    t.string   "phone"
    t.string   "email"
    t.string   "company_url"
    t.string   "tariff"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "bestpicture_file_name"
    t.string   "bestpicture_content_type"
    t.integer  "bestpicture_file_size"
    t.datetime "bestpicture_updated_at"
    t.string   "shortcut_url"
    t.text     "business_deals"
  end

  add_index "signups", ["id"], :name => "index_signups_on_id"
  add_index "signups", ["session_id"], :name => "index_signups_on_session_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "open_text_password"
    t.string   "group"
    t.string   "remember_me_token"
    t.string   "reset_password_token"
  end

end
