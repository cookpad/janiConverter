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

ActiveRecord::Schema.define(version: 20141031005252) do

  create_table "loading_banners", force: true do |t|
    t.string   "image"
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "loading_banners", ["movie_id"], name: "index_loading_banners_on_movie_id", unique: true, using: :btree

  create_table "movies", force: true do |t|
    t.string   "uuid"
    t.integer  "frame_width"
    t.integer  "frame_height"
    t.integer  "fps"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "movie"
    t.boolean  "movie_processing", default: false, null: false
    t.string   "movie_tmp"
  end

  add_index "movies", ["uuid"], name: "index_movies_on_uuid", unique: true, using: :btree

  create_table "postroll_banners", force: true do |t|
    t.text     "url"
    t.string   "image"
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "postroll_banners", ["movie_id"], name: "index_postroll_banners_on_movie_id", unique: true, using: :btree

  create_table "strips", force: true do |t|
    t.integer  "movie_id"
    t.integer  "frames_count"
    t.integer  "index"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "strips", ["movie_id", "index"], name: "index_strips_on_movie_id_and_index", using: :btree

  create_table "tracking_events", force: true do |t|
    t.string   "label"
    t.text     "url"
    t.integer  "track_on"
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "request_type", limit: 1, default: 0, null: false
  end

  add_index "tracking_events", ["movie_id", "label"], name: "index_tracking_events_on_movie_id_and_label", unique: true, using: :btree

end
