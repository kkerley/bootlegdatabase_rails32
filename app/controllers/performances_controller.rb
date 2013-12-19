class PerformancesController < ApplicationController
  before_filter :require_admin, :only => [:destroy]
  before_filter :require_user, :only => [:new, :create, :edit, :update]
  before_filter :store_location
  
  add_crumb("Performances") { |instance| instance.send :performances_path}
  
  
  # GET /performances
  # GET /performances.xml
  def index
    #@performances = Performance.paginate :page => params[:page], :order => 'date DESC'
    @performances = Performance.search(params[:search], :page => params[:page], :per_page => 25, :order => "date DESC")
    @performances_total = @performances.total_entries

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @performances }
    end
  end

  # GET /performances/1
  # GET /performances/1.xml
  def show
    @performance = Performance.find_by_permalink!(params[:id])
    @performance.revert_to(params[:version].to_i) if params[:version]
    @attendees = @performance.users
    add_crumb @performance.compact_with_band, @performance
    
    if @performance.modified_order?
      @played = PlayedSong.find(:all, :conditions => {:performance_id => @performance}, :order => "play_order ASC")
    else
      @played = @performance.songs
    end
      
      
    
    # @played = @performance.songs :order => "play_order ASC"
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @performance }
    end
  end

  # GET /performances/new
  # GET /performances/new.xml
  def new
    @performance = Performance.new
   
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @performance }
    end
  end

  # GET /performances/1/edit
  def edit
    @performance = Performance.find_by_permalink!(params[:id])
    25.times {@performance.played_songs.build}
    
  
    add_crumb @performance.compact, @performance
    
  end

  # POST /performances
  # POST /performances.xml
  def create
    @performance = Performance.new(params[:performance])
   
    
    respond_to do |format|
      if @performance.save
        flash[:notice] = 'Performance was successfully created.'
        format.html { redirect_to edit_performance_path(@performance) }
        format.xml  { render :xml => @performance, :status => :created, :location => @performance }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @performance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /performances/1
  # PUT /performances/1.xml
  def update
    @performance = Performance.find_by_permalink!(params[:id])

    respond_to do |format|
      if @performance.update_attributes(params[:performance])
        flash[:notice] = 'Performance was successfully updated.'
        format.html { redirect_to(@performance) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @performance.errors, :status => :unprocessable_entity }
      end
    end
    
  end

  # DELETE /performances/1
  # DELETE /performances/1.xml
  def destroy
    @performance = Performance.find_by_permalink!(params[:id])
    @performance.destroy

    respond_to do |format|
      format.html { redirect_to(performances_url) }
      format.xml  { head :ok }
    end
  end

  
  
  # ####################
  # Song-related methods
  
  
  # depreciated method
  # def songs
    # @performance = Performance.find_by_permalink!(params[:id])
    # @songs = @performance.songs
  # end
  
  def setlist
    @performance = Performance.find_by_permalink!(params[:id])
    @played = PlayedSong.find(:all, :conditions => {:performance_id => @performance}, :order => "play_order ASC")
  end
  

  
  # #########################
  # Performer-related methods  
  
  def performers
    @performance = Performance.find_by_permalink!(params[:id])
    @performers = @performance.performers
    add_crumb @performance.compact, @performance
  end
  
  def performer_add
    @performance = Performance.find_by_permalink!(params[:id])
    
    performer_ids = params[:performers]
    
    unless performer_ids.blank?
      performer_ids.each do |performer_id|
        performer = Performer.find(performer_id)
        unless @performance.performed_at?(performer)
          @performance.performers << performer
          flash[:notice] = "Successfully added to the show."
        end
      end
    end
    
    redirect_to @performance
  end
  
  def performer_remove
    # @performance = Performance.find(params[:id])
    @performance = Performance.find_by_permalink!(params[:id])
    
    performer_ids = params[:performers]
    
    unless performer_ids.blank?
      performer_ids.each do |performer_id|
        performer = Performer.find(performer_id)
        if @performance.performed_at?(performer)
          @performance.performers.delete(performer)
          flash[:notice] = "Removed from the show."
        end
      end
    end
    redirect_to @performance
  end
  
  
end
