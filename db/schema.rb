# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100426140832) do

  create_table "addresses", :force => true do |t|
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
    t.text     "description"
  end

  create_table "attendances", :force => true do |t|
    t.integer  "performance_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attendances", ["performance_id", "user_id"], :name => "index_attendances_on_performance_id_and_user_id", :unique => true

  create_table "bands", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
    t.text     "description"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "bands_performers", :id => false, :force => true do |t|
    t.integer  "band_id"
    t.integer  "performer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bands_performers", ["band_id", "performer_id"], :name => "index_bands_performers_on_band_id_and_performer_id", :unique => true

  create_table "bootlegs", :force => true do |t|
    t.integer  "recording_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "permalink"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "performances", :force => true do |t|
    t.date     "date"
    t.integer  "venue_id"
    t.integer  "tour_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
    t.text     "description"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.boolean  "modified_order",     :default => false
    t.boolean  "content_complete",   :default => false
  end

  create_table "performances_performers", :id => false, :force => true do |t|
    t.integer  "performance_id"
    t.integer  "performer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "performances_performers", ["performance_id", "performer_id"], :name => "index_performances_performers_on_performance_id_and_performer_id", :unique => true

  create_table "performers", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
    t.text     "description"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "played_songs", :force => true do |t|
    t.integer  "performance_id"
    t.integer  "song_id"
    t.integer  "play_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.string   "permalink"
    t.text     "content"
    t.string   "category"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recordings", :force => true do |t|
    t.integer  "performance_id"
    t.string   "recording_format"
    t.text     "lineage"
    t.text     "notes"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "taper_id"
    t.string   "name"
    t.string   "permalink"
  end

  create_table "songs", :force => true do |t|
    t.string   "name"
    t.integer  "band_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
    t.text     "description"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "tapers", :force => true do |t|
    t.string   "name"
    t.text     "preferred_equipment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  create_table "tours", :force => true do |t|
    t.string   "name"
    t.integer  "band_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
    t.text     "description"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "given_name"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.text     "address"
    t.text     "about"
    t.text     "interests"
    t.string   "occupation"
    t.string   "website"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "recording_id"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
    t.string   "perishable_token",   :default => "", :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
    t.text     "description"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "versions", :force => true do |t|
    t.integer  "versioned_id"
    t.string   "versioned_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "user_name"
    t.text     "changes"
    t.integer  "number"
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "versions", ["created_at"], :name => "index_versions_on_created_at"
  add_index "versions", ["number"], :name => "index_versions_on_number"
  add_index "versions", ["tag"], :name => "index_versions_on_tag"
  add_index "versions", ["user_id", "user_type"], :name => "index_versions_on_user_id_and_user_type"
  add_index "versions", ["user_name"], :name => "index_versions_on_user_name"
  add_index "versions", ["versioned_id", "versioned_type"], :name => "index_versions_on_versioned_id_and_versioned_type"

end
