class CreateOutputrpts < ActiveRecord::Migration
  def self.up
    create_table :outputrpts do |t|
      t.column :name, :string
      t.column :rpt_id, :integer
      t.column :finalfrgmnt_name, :string
      t.column :usr_id, :integer
      t.column :outputrpttype_id, :integer
    end
  end

  def self.down
    drop_table :outputrpts
  end
end
