class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :tagnm
      t.integer :usr_id
      t.integer :thng_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tags
  end
end
