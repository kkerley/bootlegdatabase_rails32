class VersionExistingData < ActiveRecord::Migration
  def self.up
    say_with_time "Setting initial version" do
      Address.find_each(&:touch)
      Band.find_each(&:touch)
      Bootleg.find_each(&:touch)
      Page.find_each(&:touch)
      Performance.find_each(&:touch)
      Performer.find_each(&:touch)
      PlayedSong.find_each(&:touch)
      Post.find_each(&:touch)
      Recording.find_each(&:touch)
      Song.find_each(&:touch)
      Tour.find_each(&:touch)
      Venue.find_each(&:touch)
    end
  end

  def self.down
  end
end
