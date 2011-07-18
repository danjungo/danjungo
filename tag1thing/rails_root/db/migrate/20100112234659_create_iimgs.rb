class CreateIimgs < ActiveRecord::Migration
  def self.up
    create_table :iimgs do |t|
      t.text :imgsrc
      t.integer :usr_id
      t.integer :thng_id

      t.timestamps
    end
  end

  def self.down
    drop_table :iimgs
  end
end
