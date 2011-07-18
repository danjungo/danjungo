class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.text :videohtml
      t.integer :usr_id
      t.integer :thng_id

      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
