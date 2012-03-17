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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120309162123) do

  create_table "annotations", :force => true do |t|
    t.string   "annotation",                        :null => false
    t.integer  "slide_id",                          :null => false
    t.boolean  "deleted",        :default => false, :null => false
    t.integer  "last_author_id",                    :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "annotations", ["annotation"], :name => "index_annotations_on_annotation"
  add_index "annotations", ["last_author_id"], :name => "index_annotations_on_last_author_id"
  add_index "annotations", ["slide_id"], :name => "index_annotations_on_slide_id"

  create_table "lectures", :force => true do |t|
    t.string   "title",                         :null => false
    t.boolean  "deleted",    :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "slides", :force => true do |t|
    t.string   "image",                          :null => false
    t.integer  "slideset_id",                    :null => false
    t.boolean  "deleted",     :default => false, :null => false
    t.integer  "number"
    t.integer  "position",                       :null => false
    t.integer  "title_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "slides", ["position"], :name => "index_slides_on_position"
  add_index "slides", ["slideset_id"], :name => "index_slides_on_slideset_id"
  add_index "slides", ["title_id"], :name => "index_slides_on_title_id"

  create_table "slidesets", :force => true do |t|
    t.string   "title",                          :null => false
    t.integer  "lecture_id",                     :null => false
    t.boolean  "deleted",     :default => false, :null => false
    t.text     "description"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "slidesets", ["lecture_id"], :name => "index_slidesets_on_lecture_id"

  create_table "users", :force => true do |t|
    t.string   "identity_url"
    t.string   "email"
    t.string   "name"
    t.boolean  "admin",        :default => false, :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "users", ["identity_url"], :name => "index_users_on_identity_url", :unique => true

end
