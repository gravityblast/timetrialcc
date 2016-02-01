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

ActiveRecord::Schema.define(version: 20160201023847) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "challenges", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "user_id",                              null: false
    t.string   "name",                                 null: false
    t.integer  "segment_id",                           null: false
    t.string   "segment_name",                         null: false
    t.datetime "end_time",                             null: false
    t.boolean  "calculated",           default: false, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.text     "segment_polyline"
    t.string   "segment_start_latlng"
    t.string   "segment_end_latlng"
    t.index ["calculated", "end_time"], name: "index_challenges_on_calculated_and_end_time", using: :btree
    t.index ["user_id"], name: "index_challenges_on_user_id", using: :btree
  end

  create_table "user_challenges", force: :cascade do |t|
    t.integer  "user_id"
    t.uuid     "challenge_id"
    t.datetime "created_at"
    t.index ["user_id", "challenge_id"], name: "index_user_challenges_on_user_id_and_challenge_id", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.string   "name"
    t.string   "profile_picture_url"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "access_token"
    t.index ["uid"], name: "index_users_on_uid", using: :btree
  end

end
