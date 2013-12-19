class CreatePlayedSongs < ActiveRecord::Migration
  def self.up
    create_table :played_songs do |t|
      t.integer :performance_id
      t.integer :song_id
      t.integer :play_order

      t.timestamps
    end
  end

  def self.down
    drop_table :played_songs
  end
end
