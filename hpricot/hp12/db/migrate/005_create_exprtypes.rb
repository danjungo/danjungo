class CreateExprtypes < ActiveRecord::Migration
  def self.up
    create_table :exprtypes do |t|
      t.column :name, :string
    end
  end

  def self.down
    drop_table :exprtypes
  end
end
