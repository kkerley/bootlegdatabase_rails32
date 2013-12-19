class AddPermalinksToAllModels < ActiveRecord::Migration
  def self.up
      add_column :addresses, :permalink, :string
      add_column :bands, :permalink, :string
      add_column :performances, :permalink, :string
      add_column :performers, :permalink, :string
      add_column :songs, :permalink, :string
      add_column :tours, :permalink, :string
      add_column :users, :permalink, :string
      add_column :venues, :permalink, :string
  end

  def self.down
      remove_column :addresses, :permalink
      remove_column :bands, :permalink
      remove_column :performances, :permalink
      remove_column :performers, :permalink
      remove_column :songs, :permalink
      remove_column :tours, :permalink
      remove_column :users, :permalink
      remove_column :venues, :permalink
  end
end
