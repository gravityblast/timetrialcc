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

ActiveRecord::Schema.define(version: 20160202154119) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "activities", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "event_name"
    t.uuid     "recipient_id"
    t.string   "originator_type"
    t.uuid     "originator_id"
    t.string   "subject_type"
    t.uuid     "subject_id"
    t.datetime "event_created_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["event_created_at"], name: "index_activities_on_event_created_at", using: :btree
    t.index ["recipient_id"], name: "index_activities_on_recipient_id", using: :btree
  end

  create_table "challenges", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "user_id",                              null: false
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

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.json     "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "queue_classic_jobs", id: :bigserial, force: :cascade do |t|
    t.text     "q_name",                         null: false
    t.text     "method",                         null: false
    t.json     "args",                           null: false
    t.datetime "locked_at"
    t.integer  "locked_by"
    t.datetime "created_at",   default: "now()"
    t.datetime "scheduled_at", default: "now()"
    t.index ["q_name", "id"], name: "idx_qc_on_name_only_unlocked", where: "(locked_at IS NULL)", using: :btree
    t.index ["scheduled_at", "id"], name: "idx_qc_on_scheduled_at_only_unlocked", where: "(locked_at IS NULL)", using: :btree
  end

  create_table "user_challenges", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "user_id"
    t.uuid     "challenge_id"
    t.datetime "created_at"
    t.integer  "moving_time"
    t.index ["user_id", "challenge_id"], name: "index_user_challenges_on_user_id_and_challenge_id", unique: true, using: :btree
  end

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
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
