class Hp < ActiveRecord::Migration
  def self.up
    create_table "exprtypes" do |t|
      t.string :name
    end # exprtypes

    create_table "frgmnts" do |t|
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
    end # frgmnts

    create_table "stcks" do |t|
      t.string  "name"
    end

    create_table "usrs" do |t|
      t.column :login, :string, :limit => 80, :null => false
      t.column :salted_password, :string, :limit => 40, :null => false
      t.column :email, :string, :limit => 60, :null => false
      t.column :first_name, :string, :limit => 40
      t.column :last_name, :string, :limit => 40
      t.column :salt, 'CHAR(40)', :null => false
      t.column :verified, :boolean, :default => false
      t.column :role, :string, :limit => 40, :default => nil
      t.column :security_token, 'CHAR(40)', :default => nil
      t.column :token_expiry, :datetime, :default => nil
      t.column :deleted, :boolean, :default => false
    end

  end # self.up

  def self.down
  end
end
