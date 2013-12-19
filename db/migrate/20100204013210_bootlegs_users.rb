class BootlegsUsers < ActiveRecord::Migration
  def self.up
    create_table :bootlegs_users, :id => false do |t|
      t.integer :bootleg_id, :null => false
      t.integer :user_id, :null => false
    end
    
    # Add index to speed up looking up the connection and ensure users only add a bootleg once
    add_index :bootlegs_users, [:bootleg_id, :user_id], :unique => true
  end

  def self.down
    remove_index :bootlegs_users, :column => [:bootleg_id, :student_id]
    drop_table :bootlegs_users
  end
end
