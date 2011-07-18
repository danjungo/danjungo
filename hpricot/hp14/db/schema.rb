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

ActiveRecord::Schema.define(:version => 20091221024828) do

  create_table "exprtypes", :force => true do |t|
    t.string "name"
  end

  create_table "frgmnts", :force => true do |t|
    t.string  "name"
    t.string  "arg1"
    t.string  "arg2"
    t.string  "arg3"
    t.string  "arg4"
    t.text    "frgtxt"
    t.string  "inputurl"
    t.integer "parent_id"
    t.integer "stck_id"
    t.integer "exprtype_id"
    t.integer "usr_id"
  end

  create_table "stcks", :force => true do |t|
    t.string "name"
  end

  create_table "usrs", :force => true do |t|
    t.string   "login",           :limit => 80,                    :null => false
    t.string   "salted_password", :limit => 40,                    :null => false
    t.string   "email",           :limit => 60,                    :null => false
    t.string   "first_name",      :limit => 40
    t.string   "last_name",       :limit => 40
    t.string   "salt",            :limit => 40,                    :null => false
    t.boolean  "verified",                      :default => false
    t.string   "role",            :limit => 40
    t.string   "security_token",  :limit => 40
    t.datetime "token_expiry"
    t.boolean  "deleted",                       :default => false
  end

end
