class CreateFrqtags < ActiveRecord::Migration
  def self.up
    create_table :frqtags do |t|
      t.string :tgnm

      t.timestamps
    end
  end

  def self.down
    drop_table :frqtags
  end
end
