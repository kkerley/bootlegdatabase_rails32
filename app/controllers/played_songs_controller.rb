class PlayedSongsController < ApplicationController
  def index
    @played_songs = PlayedSong.all
  end

  def edit
    @played_song = PlayedSong.find(params[:id])
  end 
  
  def show
    @played_song = PlayedSong.find(params[:id])
    @played_song.revert_to(params[:version].to_i) if params[:version]
  end

end
