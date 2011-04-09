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

ActiveRecord::Schema.define(:version => 20110409125513) do

  create_table "business_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "business_types", ["id"], :name => "index_business_types_on_id"

  create_table "companies", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "contact_mail"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["id"], :name => "index_locations_on_id"

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
  end

  add_index "signups", ["id"], :name => "index_signups_on_id"
  add_index "signups", ["session_id"], :name => "index_signups_on_session_id"

end
