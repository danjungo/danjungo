class CreateRpttypes < ActiveRecord::Migration
  def self.up
    create_table :rpttypes do |t|
      t.column :name, :string
      t.column :usr_id, :integer
    end
  end

  def self.down
    drop_table :rpttypes
  end
end
