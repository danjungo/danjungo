# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 1) do

  create_table "frms", :force => true do |t|
    t.column "name",   :string
    t.column "dsc",    :string
    t.column "uurl",   :string
    t.column "prvt",   :boolean
    t.column "usr_id", :integer
  end

  create_table "frms_grps", :id => false, :force => true do |t|
    t.column "frm_id", :integer
    t.column "grp_id", :integer
  end

  create_table "frms_prsnas", :id => false, :force => true do |t|
    t.column "frm_id",   :integer
    t.column "prsna_id", :integer
  end

  create_table "frms_psts", :id => false, :force => true do |t|
    t.column "frm_id", :integer
    t.column "pst_id", :integer
  end

  create_table "gcategs", :force => true do |t|
    t.column "name",   :string
    t.column "dsc",    :string
    t.column "uurl",   :string
    t.column "prvt",   :boolean
    t.column "usr_id", :integer
  end

  create_table "gcategs_grps", :id => false, :force => true do |t|
    t.column "gcateg_id", :integer
    t.column "grp_id",    :integer
  end

  create_table "grps", :force => true do |t|
    t.column "name",   :string
    t.column "dsc",    :string
    t.column "uurl",   :string
    t.column "prvt",   :boolean
    t.column "usr_id", :integer
  end

  create_table "prsnas", :force => true do |t|
    t.column "name",   :string
    t.column "eml",    :string
    t.column "psswd",  :string
    t.column "usr_id", :integer
  end

  create_table "psts", :force => true do |t|
    t.column "name",     :string
    t.column "usr_id",   :integer
    t.column "prsna_id", :integer
  end

  create_table "sessions", :force => true do |t|
    t.column "session_id", :string
    t.column "data",       :text
    t.column "updated_at", :datetime
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "urlls", :force => true do |t|
    t.column "name",   :string
    t.column "pst_id", :integer
  end

  create_table "usrs", :force => true do |t|
    t.column "login",           :string,   :limit => 80,                    :null => false
    t.column "salted_password", :string,   :limit => 40,                    :null => false
    t.column "email",           :string,   :limit => 60,                    :null => false
    t.column "first_name",      :string,   :limit => 40
    t.column "last_name",       :string,   :limit => 40
    t.column "salt",            :string,   :limit => 40,                    :null => false
    t.column "verified",        :boolean,                :default => false
    t.column "role",            :string,   :limit => 40
    t.column "security_token",  :string,   :limit => 40
    t.column "token_expiry",    :datetime
    t.column "deleted",         :boolean,                :default => false
  end

end
