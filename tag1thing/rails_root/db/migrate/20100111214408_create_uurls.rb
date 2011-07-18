class CreateUurls < ActiveRecord::Migration
  def self.up
    create_table :uurls do |t|
      t.text :hhref
      t.integer :usr_id
      t.integer :thng_id

      t.timestamps
    end
  end

  def self.down
    drop_table :uurls
  end
end
