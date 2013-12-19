class ChangeFormatColumnName < ActiveRecord::Migration
  def self.up
    rename_column :recordings, :format, :recording_format
  end

  def self.down
  end
end
