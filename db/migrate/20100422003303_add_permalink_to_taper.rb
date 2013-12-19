class AddPermalinkToTaper < ActiveRecord::Migration
  def self.up
    add_column :tapers, :permalink, :string
    add_column :recordings, :permalink, :string
  end

  def self.down
    remove_column :tapers, :permalink
    remove_column :recordings, :permalink
  end
end
