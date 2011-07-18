class CreateRpts < ActiveRecord::Migration
  def self.up
    create_table :rpts do |t|
      t.column :name, :string
      t.column :uurl, :string
      t.column :enddate, :date
      t.column :symbl_id, :integer
      t.column :usr_id, :integer
      t.column :rpttype_id, :integer
    end
  end

  def self.down
    drop_table :rpts
  end
end
