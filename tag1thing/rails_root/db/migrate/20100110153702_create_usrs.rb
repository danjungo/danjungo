class CreateUsrs < ActiveRecord::Migration
  def self.up
    create_table :usrs do |t|
      t.string :opndd
      t.string :usrnm
      t.boolean :admn

      t.timestamps
    end
  end

  def self.down
    drop_table :usrs
  end
end
