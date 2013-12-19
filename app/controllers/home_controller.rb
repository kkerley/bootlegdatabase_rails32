class HomeController < ApplicationController
  def index
    @homes = Page.all
    @posts = Post.find(:all, :limit => 2, :order => 'created_at DESC')
    
    @performances = Performance.all
    @recordings = Recording.all
    @tours = Tour.all
    @venues = Venue.all
    @performers = Performer.all
    @songs = Song.all
    @users = User.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @homes }
    end
  end

end
