class VenuesController < ApplicationController
  before_filter :require_admin, :only => [:destroy]
  before_filter :require_user, :only => [:new, :create, :edit, :update]
  before_filter :store_location
    
  add_crumb("Venues"){|instance| instance.send :venues_path}
  

  
  # GET /venues
  # GET /venues.xml
  def index
    if params[:q]
      # @venues = Venue.find(:all, :conditions => {:name => params[:q]}, :order => 'name ASC')
      @venues = Venue.find(:all, :conditions => ["name like ?", params[:q] + '%'], :order => 'name ASC')     
    else
      @venues = Venue.paginate :page => params[:page], :order => 'name ASC'  
    end
    
    
    
    # @venues = Venue.all

    respond_to do |wants|
      wants.html
      wants.js
    # respond_to do |format|  
      #format.html # index.html.erb
      #format.xml  { render :xml => @venues }
    end
  end

  # GET /venues/1
  # GET /venues/1.xml
  def show
    # @venue = Venue.find(params[:id])
    @venue = Venue.find_by_permalink!(params[:id])
    @venue.revert_to(params[:version].to_i) if params[:version]
    add_crumb @venue.name, @venue
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @venue }
    end
  end

  # GET /venues/new
  # GET /venues/new.xml
  def new
    @venue = Venue.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @venue }
    end
  end

  # GET /venues/1/edit
  def edit
    # @venue = Venue.find(params[:id])
    @venue = Venue.find_by_permalink!(params[:id])
    add_crumb @venue.name, @venue
  end

  # POST /venues
  # POST /venues.xml
  def create
    @venue = Venue.new(params[:venue])    
    @venue.create_permalink
    
    respond_to do |format|
      if @venue.save
        flash[:notice] = 'Venue was successfully created.'
        format.html { redirect_to(@venue) }
        format.xml  { render :xml => @venue, :status => :created, :location => @venue }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @venue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /venues/1
  # PUT /venues/1.xml
  def update
    # @venue = Venue.find(params[:id])
    @venue = Venue.find_by_permalink!(params[:id])
    
    respond_to do |format|
      if @venue.update_attributes(params[:venue])
        flash[:notice] = 'Venue was successfully updated.'
        format.html { redirect_to(@venue) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @venue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /venues/1
  # DELETE /venues/1.xml
  def destroy
    # @venue = Venue.find(params[:id])
    @venue = Venue.find_by_permalink!(params[:id])
    @venue.destroy

    respond_to do |format|
      format.html { redirect_to(venues_url) }
      format.xml  { head :ok }
    end
  end
  
end
