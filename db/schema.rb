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

ActiveRecord::Schema.define(:version => 20120312103931) do

  create_table "annotations", :force => true do |t|
    t.string   "annotation"
    t.integer  "slide_id"
    t.boolean  "deleted",        :default => false, :null => false
    t.integer  "last_author_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "lectures", :force => true do |t|
    t.string   "title"
    t.boolean  "deleted",    :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "slides", :force => true do |t|
    t.string   "image"
    t.integer  "slideset_id"
    t.boolean  "deleted",     :default => false, :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "position"
    t.integer  "title_id"
  end

  create_table "slidesets", :force => true do |t|
    t.string   "title"
    t.integer  "lecture_id"
    t.boolean  "deleted",     :default => false, :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.text     "description"
  end

  create_table "users", :force => true do |t|
    t.string   "identity_url"
    t.string   "email"
    t.string   "name"
    t.boolean  "admin"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "users", ["identity_url"], :name => "index_users_on_identity_url", :unique => true

end
