class CreateAttendances < ActiveRecord::Migration
  def self.up
    create_table :attendances do |t|
      t.integer :performance_id
      t.integer :user_id

      t.timestamps
    end
    add_index :attendances, [:performance_id, :user_id], :unique => true
  end

  def self.down
    remove_index :attendances, :column => [:performance_id, :user_id]
    drop_table :attendances
  end
end
