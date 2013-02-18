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

ActiveRecord::Schema.define(:version => 20130218023752) do

  create_table "brackets", :force => true do |t|
    t.boolean  "is_official", :default => false
    t.integer  "user_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "brackets", ["user_id"], :name => "index_brackets_on_user_id"

  create_table "games", :force => true do |t|
    t.integer  "bracket_id"
    t.integer  "team_one_id"
    t.integer  "team_two_id"
    t.integer  "winning_team_id"
    t.integer  "next_game_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "score",           :default => 0
  end

  add_index "games", ["bracket_id"], :name => "index_games_on_bracket_id"

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "rank",       :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "fb_id"
    t.string   "gender"
    t.string   "timezone"
    t.string   "fb_username"
    t.string   "fb_access_token"
  end

  add_index "users", ["fb_access_token"], :name => "index_users_on_fb_access_token"
  add_index "users", ["fb_id"], :name => "index_users_on_fb_id"

end
