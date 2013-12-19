class PerformancesSongs < ActiveRecord::Migration
  def self.up
    create_table :performances_songs, :id => false do |t|
      t.integer :performance_id
      t.integer :song_id

      t.timestamps
    end
    add_index :performances_songs, [:performance_id, :song_id], :unique => true
  end

  def self.down
    remove_index :performances_songs, :column => [:performance_id, :song_id]
    drop_table :performances_songs
  end
end
