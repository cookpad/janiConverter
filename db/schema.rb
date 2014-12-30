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

ActiveRecord::Schema.define(version: 20141119083935) do

  create_table "loading_banners", force: :cascade do |t|
    t.string   "image",      limit: 255
    t.integer  "movie_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "loading_banners", ["movie_id"], name: "index_loading_banners_on_movie_id", unique: true, using: :btree

  create_table "movies", force: :cascade do |t|
    t.string   "uuid",              limit: 255
    t.integer  "frame_width",       limit: 4
    t.integer  "frame_height",      limit: 4
    t.integer  "fps",               limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "movie",             limit: 255
    t.boolean  "movie_processing",  limit: 1,   default: false, null: false
    t.string   "movie_tmp",         limit: 255
    t.integer  "conversion_status", limit: 1,   default: 0,     null: false
    t.integer  "pixel_ratio",       limit: 4,   default: 1,     null: false
  end

  add_index "movies", ["conversion_status"], name: "index_movies_on_conversion_status", using: :btree
  add_index "movies", ["uuid"], name: "index_movies_on_uuid", unique: true, using: :btree

  create_table "postroll_banners", force: :cascade do |t|
    t.text     "url",        limit: 65535
    t.string   "image",      limit: 255
    t.integer  "movie_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "postroll_banners", ["movie_id"], name: "index_postroll_banners_on_movie_id", unique: true, using: :btree

  create_table "previews", force: :cascade do |t|
    t.integer  "movie_id",   limit: 4
    t.string   "html",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "previews", ["movie_id"], name: "index_previews_on_movie_id", unique: true, using: :btree

  create_table "strips", force: :cascade do |t|
    t.integer  "movie_id",     limit: 4
    t.integer  "frames_count", limit: 4
    t.integer  "index",        limit: 4
    t.string   "image",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "strips", ["movie_id", "index"], name: "index_strips_on_movie_id_and_index", using: :btree

  create_table "tracking_events", force: :cascade do |t|
    t.string   "label",        limit: 255
    t.text     "url",          limit: 65535
    t.integer  "track_on",     limit: 4
    t.integer  "movie_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "request_type", limit: 1,     default: 0, null: false
  end

  add_index "tracking_events", ["movie_id", "label"], name: "index_tracking_events_on_movie_id_and_label", unique: true, using: :btree

end
