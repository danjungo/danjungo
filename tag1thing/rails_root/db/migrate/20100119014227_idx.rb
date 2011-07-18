class Idx < ActiveRecord::Migration
  def self.up
    add_index "cmmnts", ["thng_id","usr_id"],                  :name => "cmmnts_n1"
    add_index "frqtags", ["tgnm"],                             :name => "frqtags_n1"
    add_index "iimgs", ["thng_id","usr_id"],                   :name => "iimgs_n1"
    add_index "open_id_associations", ["handle","assoc_type"], :name => "oid_ass_n1"
    add_index "open_id_nonces", ["server_url","timestamp"],    :name => "oid_nonces_n1"
    add_index "srchs", ["usr_id","srchphrase"],                :name => "srchs_n1"
    add_index "tags", ["tagnm"],                               :name => "tags_n1"
    add_index "thngs", ["usr_id","thngnm"],                    :name => "thngs_n1"
    add_index "usrs", ["usrnm","opndd"],                       :name => "usrs_n1"
    add_index "uurls", ["hhref"],                              :name => "uurls_n1"
    add_index "videos", ["thng_id","usr_id"],                  :name => "videos_n1"
  end

  def self.down
    execute "drop index cmmnts_n1"
    execute "drop index frqtags_n1"
    execute "drop index iimgs_n1"
    execute "drop index oid_ass_n1"
    execute "drop index oid_nonces_n1"
    execute "drop index srchs_n1"
    execute "drop index tags_n1"
    execute "drop index thngs_n1"
    execute "drop index usrs_n1"
    execute "drop index uurls_n1"
    execute "drop index videos_n1"
  end
end
