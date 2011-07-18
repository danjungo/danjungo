class CreateCmmnts < ActiveRecord::Migration
  def self.up
    create_table :cmmnts do |t|
      t.text :cmmntxt
      t.integer :usr_id
      t.integer :thng_id

      t.timestamps
    end
  end

  def self.down
    drop_table :cmmnts
  end
end
