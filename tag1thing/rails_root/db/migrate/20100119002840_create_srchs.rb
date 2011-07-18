class CreateSrchs < ActiveRecord::Migration
  def self.up
    create_table :srchs do |t|
      t.string :srchtype
      t.string :srchphrase
      t.boolean :usr_scoped
      t.integer :usr_id

      t.timestamps
    end
  end

  def self.down
    drop_table :srchs
  end
end
