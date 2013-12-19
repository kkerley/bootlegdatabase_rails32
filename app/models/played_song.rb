class PlayedSong < ActiveRecord::Base
  versioned
  
  belongs_to :performance
  belongs_to :song
   
  
  def song_name
    song.name if song unless song.blank?
  end
  
  def song_name=(name)
    # self.song = Song.find_by_name!(name) unless name.blank?
    self.song = Song.find_or_create_by_name(name){|u| u.band_id = 2 } unless name.blank?
  end
  
end
