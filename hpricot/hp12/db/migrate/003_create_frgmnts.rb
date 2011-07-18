class CreateFrgmnts < ActiveRecord::Migration
  def self.up
    create_table :frgmnts do |t|
      t.column :name, :string
      t.column :arg1, :string
      t.column :arg2, :string
      t.column :arg3, :string
      t.column :arg4, :string
      t.column :frgtxt, :text
      t.column :inputurl, :string
      t.column :parent_id, :integer
      t.column :stck_id, :integer
      t.column :exprtype_id, :integer
      t.column :usr_id, :integer
    end
  end

  def self.down
    drop_table :frgmnts
  end
end

