class AddContentCompleteBooleanToPerformance < ActiveRecord::Migration
  def self.up
    add_column :performances, :content_complete, :boolean, :default => 0
  end

  def self.down
    remove_column :performances, :content_complete
  end
end
