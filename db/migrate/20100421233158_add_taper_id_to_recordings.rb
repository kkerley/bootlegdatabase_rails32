class AddTaperIdToRecordings < ActiveRecord::Migration
  def self.up
    add_column :recordings, :taper_id, :integer
    add_column :recordings, :name, :string
  end

  def self.down
    remove_column :recordings, :name
    remove_column :recordings, :taper_id
  end
end
