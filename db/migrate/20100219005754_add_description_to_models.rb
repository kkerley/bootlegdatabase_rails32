class AddDescriptionToModels < ActiveRecord::Migration
  def self.up
    add_column :addresses, :description, :text
    add_column :bands, :description, :text
    add_column :performances, :description, :text
    add_column :performers, :description, :text
    add_column :songs, :description, :text
    add_column :tours, :description, :text
    add_column :venues, :description, :text
  end

  def self.down
    remove_column :addresses, :description
    remove_column :bands, :description
    remove_column :performances, :description
    remove_column :performers, :description
    remove_column :songs, :description
    remove_column :tours, :description
    remove_column :venues, :description
  end
end
