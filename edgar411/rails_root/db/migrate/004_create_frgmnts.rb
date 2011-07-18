class CreateFrgmnts < ActiveRecord::Migration
  def self.up
    create_table :frgmnts do |t|
      t.column :name, :string
      t.column :scrapeexpr, :text
      t.column :exprtype, :string
      t.column :frgtxt, :text
      t.column :inputurl, :string
      t.column :parent_id, :integer
      t.column :rpt_id, :integer
      t.column :outputrpt_id, :integer
      t.column :exprtype_id, :integer
      t.column :usr_id, :integer
    end
  end

  def self.down
    drop_table :frgmnts
  end
end
