class ToursController < ApplicationController
  before_filter :require_admin, :only => [:destroy]
  before_filter :require_user, :only => [:new, :create, :edit, :update]
  before_filter :store_location
  
  add_crumb("Tours"){|instance| instance.send :tours_path}
  
  
  # GET /tours
  # GET /tours.xml
  def index
    if params[:q]
      # @tours = Tour.find(:all, :conditions => {:name => params[:q]}, :order => 'name ASC')
      @tours = Tour.find(:all, :conditions => ["name like ?", params[:q] + '%'], :order => 'name ASC')
    else
      @tours = Tour.all  
    end
   
    respond_to do |wants|
      wants.html
      wants.js
    # respond_to do |format|
     # format.html # index.html.erb
      # format.xml  { render :xml => @tours }
    end
  end

  # GET /tours/1
  # GET /tours/1.xml
  def show
    # @tour = Tour.find(params[:id])
    @tour = Tour.find_by_permalink(params[:id])
    @performances = Performance.find(:all, :conditions => {:tour_id => @tour.id}, :order => 'date DESC')
    @tour.revert_to(params[:version].to_i) if params[:version]
    add_crumb @tour.name, @tour
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tour }
    end
  end

  # GET /tours/new
  # GET /tours/new.xml
  def new
    @tour = Tour.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tour }
    end
  end

  # GET /tours/1/edit
  def edit
    # @tour = Tour.find(params[:id])
    @tour = Tour.find_by_permalink(params[:id])
    add_crumb @tour.name, @tour
  end

  # POST /tours
  # POST /tours.xml
  def create
    @tour = Tour.new(params[:tour])
    @tour.create_permalink

    respond_to do |format|
      if @tour.save
        flash[:notice] = 'Tour was successfully created.'
        format.html { redirect_to(@tour) }
        format.xml  { render :xml => @tour, :status => :created, :location => @tour }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tour.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tours/1
  # PUT /tours/1.xml
  def update
    # @tour = Tour.find(params[:id])
    @tour = Tour.find_by_permalink(params[:id])
    
    respond_to do |format|
      if @tour.update_attributes(params[:tour])
        flash[:notice] = 'Tour was successfully updated.'
        format.html { redirect_to(@tour) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tour.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tours/1
  # DELETE /tours/1.xml
  def destroy
    # @tour = Tour.find(params[:id])
    @tour = Tour.find_by_permalink(params[:id])
    @tour.destroy

    respond_to do |format|
      format.html { redirect_to(tours_url) }
      format.xml  { head :ok }
    end
  end
  
  def concerts
    # @tour = Tour.find(params[:id])
    @tour = Tour.find_by_permalink(params[:id])
    @performances = @tour.performances
  end
  
end
