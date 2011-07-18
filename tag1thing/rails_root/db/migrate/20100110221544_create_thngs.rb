class CreateThngs < ActiveRecord::Migration
  def self.up
    create_table :thngs do |t|
      t.string  :shrturl
      t.string  :thngnm
      t.string  :thngwhy
      t.date    :thngwhen
      t.text    :thngdsc
      t.boolean :layouttf
      t.integer :usr_id

      t.timestamps
    end
  end

  def self.down
    drop_table :thngs
  end
end
