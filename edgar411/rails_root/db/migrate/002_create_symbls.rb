class CreateSymbls < ActiveRecord::Migration
  def self.up
    create_table :symbls do |t|
      t.column :name, :string
      t.column :cname, :string
      t.column :usr_id, :integer
    end
  end

  def self.down
    drop_table :symbls
  end
end
