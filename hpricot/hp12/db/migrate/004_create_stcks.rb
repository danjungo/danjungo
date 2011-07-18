class CreateStcks < ActiveRecord::Migration
  def self.up
    create_table :stcks do |t|
      t.column :name, :string
    end
  end

  def self.down
    drop_table :stcks
  end
end
