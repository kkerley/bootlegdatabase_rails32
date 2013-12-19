class AddModifiedOrderBooleanToPerformances < ActiveRecord::Migration
  def self.up
    add_column :performances, :modified_order, :boolean, :default => 0
  end

  def self.down
    remove_column :performances, :modified_order
  end
end
