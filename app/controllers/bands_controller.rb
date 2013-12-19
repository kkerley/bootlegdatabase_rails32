class BandsController < ApplicationController
  before_filter :require_admin, :only => [:new, :create, :edit, :update, :destroy]
  # before_filter :require_user, :only => [:new, :create, :edit, :update]
  before_filter :store_location
  
  add_crumb("Bands"){ |instance| instance.send :bands_path}
  
  # GET /bands
  # GET /bands.xml
  def index
    @bands = Band.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bands }
    end
  end

  # GET /bands/1
  # GET /bands/1.xml
  def show
    # @band = Band.find(params[:id])
    @band = Band.find_by_permalink(params[:id])
    @tours = @band.tours
    @band.revert_to(params[:version].to_i) if params[:version]
    add_crumb @band.name, @band
    
    # @performances = Performance.find(:all, :conditions => {:tour_id => @tours.each.id})

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @band }
    end
  end

  # GET /bands/new
  # GET /bands/new.xml
  def new
    @band = Band.new
  

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @band }
    end
  end

  # GET /bands/1/edit
  def edit
    # @band = Band.find(params[:id])
    @band = Band.find_by_permalink(params[:id])
    add_crumb @band.name, @band
  end

  # POST /bands
  # POST /bands.xml
  def create
    @band = Band.new(params[:band])
    @band.create_permalink
    
    respond_to do |format|
      if @band.save
        flash[:notice] = 'Band was successfully created.'
        format.html { redirect_to(@band) }
        format.xml  { render :xml => @band, :status => :created, :location => @band }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @band.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bands/1
  # PUT /bands/1.xml
  def update
    # @band = Band.find(params[:id])
    @band = Band.find_by_permalink(params[:id])
    
    respond_to do |format|
      if @band.update_attributes(params[:band])
        flash[:notice] = 'Band was successfully updated.'
        format.html { redirect_to(@band) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @band.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bands/1
  # DELETE /bands/1.xml
  def destroy
    #@band = Band.find(params[:id])
    @band = Band.find_by_permalink(params[:id])
    @band.destroy

    respond_to do |format|
      format.html { redirect_to(bands_url) }
      format.xml  { head :ok }
    end
  end

  
  
  
  # GET /bands/1/bandmates
  def bandmates
    @band = Band.find_by_permalink(params[:id])
  end

  # Methods for adding tours
  # GET /bands/1/tours
  def tours
    @band = Band.find_by_permalink(params[:id])
  end
  
  def songs
    @band = Band.find_by_permalink(params[:id])
  end
  
  def performances
    @band = Band.find_by_permalink(params[:id])
  end
  
end
