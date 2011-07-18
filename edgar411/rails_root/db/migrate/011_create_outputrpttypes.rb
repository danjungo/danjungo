class CreateOutputrpttypes < ActiveRecord::Migration
  def self.up
    create_table :outputrpttypes do |t|
      t.column :name, :string
      t.column :usr_id, :integer
    end
  end

  def self.down
    drop_table :outputrpttypes
  end
end
