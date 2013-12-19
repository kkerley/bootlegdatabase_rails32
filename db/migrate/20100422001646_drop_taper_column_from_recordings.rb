class DropTaperColumnFromRecordings < ActiveRecord::Migration
  def self.up
    remove_column :recordings, :taper
  end

  def self.down
  end
end
