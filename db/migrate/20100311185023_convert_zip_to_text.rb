class ConvertZipToText < ActiveRecord::Migration
  def self.up
    change_column :addresses, :zip, :string
  end

  def self.down
    change_column :addresses, :zip, :integer
  end
end
