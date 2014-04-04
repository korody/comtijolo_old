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

ActiveRecord::Schema.define(version: 20140404150015) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "attachments", force: true do |t|
    t.string   "file"
    t.text     "note"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachments", ["attachable_id", "attachable_type"], name: "index_attachments_on_attachable_id_and_attachable_type", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_categories", force: true do |t|
    t.integer  "post_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_categories", ["category_id"], name: "index_post_categories_on_category_id", using: :btree
  add_index "post_categories", ["post_id"], name: "index_post_categories_on_post_id", using: :btree

  create_table "posts", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "content"
    t.string   "slug"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "recommended", default: false, null: false
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "post_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["post_id"], name: "index_taggings_on_post_id", using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "bio"
    t.string   "remember_token"
    t.string   "password_digest"
    t.string   "reset_token"
    t.datetime "reset_token_sent_at"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", force: true do |t|
    t.string   "link"
    t.text     "note"
    t.integer  "filmable_id"
    t.string   "filmable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "videos", ["filmable_id", "filmable_type"], name: "index_videos_on_filmable_id_and_filmable_type", using: :btree

end
