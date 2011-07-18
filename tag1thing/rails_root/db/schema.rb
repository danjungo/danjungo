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

ActiveRecord::Schema.define(:version => 20100119014227) do

  create_table "cmmnts", :force => true do |t|
    t.text     "cmmntxt"
    t.integer  "usr_id"
    t.integer  "thng_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cmmnts", ["thng_id", "usr_id"], :name => "cmmnts_n1"

  create_table "frqtags", :force => true do |t|
    t.string   "tgnm"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "frqtags", ["tgnm"], :name => "frqtags_n1"

  create_table "iimgs", :force => true do |t|
    t.text     "imgsrc"
    t.integer  "usr_id"
    t.integer  "thng_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "iimgs", ["thng_id", "usr_id"], :name => "iimgs_n1"

  create_table "open_id_associations", :force => true do |t|
    t.binary  "server_url", :null => false
    t.string  "handle",     :null => false
    t.binary  "secret",     :null => false
    t.integer "issued",     :null => false
    t.integer "lifetime",   :null => false
    t.string  "assoc_type", :null => false
  end

  add_index "open_id_associations", ["handle", "assoc_type"], :name => "oid_ass_n1"

  create_table "open_id_nonces", :force => true do |t|
    t.string  "server_url", :null => false
    t.integer "timestamp",  :null => false
    t.string  "salt",       :null => false
  end

  add_index "open_id_nonces", ["server_url", "timestamp"], :name => "oid_nonces_n1"

  create_table "srchs", :force => true do |t|
    t.string   "srchtype"
    t.string   "srchphrase"
    t.boolean  "usr_scoped"
    t.integer  "usr_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "srchs", ["usr_id", "srchphrase"], :name => "srchs_n1"

  create_table "tags", :force => true do |t|
    t.string   "tagnm"
    t.integer  "usr_id"
    t.integer  "thng_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["tagnm"], :name => "tags_n1"

  create_table "thngs", :force => true do |t|
    t.string   "shrturl"
    t.string   "thngnm"
    t.string   "thngwhy"
    t.date     "thngwhen"
    t.text     "thngdsc"
    t.boolean  "layouttf"
    t.integer  "usr_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "thngs", ["usr_id", "thngnm"], :name => "thngs_n1"

  create_table "usrs", :force => true do |t|
    t.string   "opndd"
    t.string   "usrnm"
    t.boolean  "admn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "usrs", ["usrnm", "opndd"], :name => "usrs_n1"

  create_table "uurls", :force => true do |t|
    t.text     "hhref"
    t.integer  "usr_id"
    t.integer  "thng_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "uurls", ["hhref"], :name => "uurls_n1"

  create_table "videos", :force => true do |t|
    t.text     "videohtml"
    t.integer  "usr_id"
    t.integer  "thng_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "videos", ["thng_id", "usr_id"], :name => "videos_n1"

end
