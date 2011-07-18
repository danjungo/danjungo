class CreateBcrmbs < ActiveRecord::Migration
  def self.up
    create_table :bcrmbs do |t|
      t.column :name, :string
      t.column :bckey, :string
      t.column :usr_id, :integer
    end
  end

  def self.down
    drop_table :bcrmbs
  end
end
