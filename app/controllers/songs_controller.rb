class SongsController < ApplicationController
  before_filter :require_admin, :only => [:destroy]
  before_filter :require_user, :only => [:new, :create, :edit, :update]
  before_filter :store_location
  
  add_crumb ("Songs") {|instance| instance.send :songs_path}
  
  
  # GET /songs
  # GET /songs.xml
  def index
   
    if params[:q]
      @songs = Song.find(:all, :conditions => ["name like ?", params[:q] + '%'], :order => 'name ASC')     
    else
      @songs = Song.paginate :page => params[:page], :order => 'name ASC'
    end
    

   respond_to do |wants|
      wants.html
      wants.js
    #respond_to do |format|
      #format.html # index.html.erb
      #format.xml  { render :xml => @songs }
      #format.js
    end
  end

  # GET /songs/1
  # GET /songs/1.xml
  def show
    @song = Song.find_by_permalink(params[:id])
    @song.revert_to(params[:version].to_i) if params[:version]
    add_crumb @song.name, @song
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @song }
    end
  end

  # GET /songs/new
  # GET /songs/new.xml
  def new
    @song = Song.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @song }
    end
  end

  # GET /songs/1/edit
  def edit
    #@song = Song.find(params[:id])
    @song = Song.find_by_permalink(params[:id])
    add_crumb @song.name, @song
  end

  # POST /songs
  # POST /songs.xml
  def create
    @song = Song.new(params[:song])
    @song.create_permalink
    
    respond_to do |format|
      if @song.save
        flash[:notice] = 'Song was successfully created.'
        format.html { redirect_to(@song) }
        format.xml  { render :xml => @song, :status => :created, :location => @song }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @song.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /songs/1
  # PUT /songs/1.xml
  def update
    #@song = Song.find(params[:id])
    @song = Song.find_by_permalink(params[:id])

    respond_to do |format|
      if @song.update_attributes(params[:song])
        flash[:notice] = 'Song was successfully updated.'
        format.html { redirect_to(@song) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @song.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.xml
  def destroy
    @song = Song.find_by_permalink(params[:id])
    @song.destroy

    respond_to do |format|
      format.html { redirect_to(songs_url) }
      format.xml  { head :ok }
    end
  end

  
end
