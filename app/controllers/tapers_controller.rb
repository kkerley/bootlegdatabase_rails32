class TapersController < ApplicationController
  before_filter :require_admin, :only => [:destroy]
  before_filter :require_user, :only => [:new, :create, :edit, :update]
  before_filter :store_location

  
  add_crumb("Tapers") { |instance| instance.send :tapers_path}
  # GET /tapers
  # GET /tapers.xml
  def index
     if params[:q]
      @tapers = Taper.find(:all, :conditions => ["name like ?", params[:q] + '%'], :order => 'name ASC')     
    else
      @tapers = Taper.paginate :page => params[:page], :order => 'name ASC'
    end
   
    respond_to do |wants|
      wants.html
      wants.js  
    # respond_to do |format|
      # format.html # index.html.erb
      # format.xml  { render :xml => @tapers }
    end
  end

  # GET /tapers/1
  # GET /tapers/1.xml
  def show
    @taper = Taper.find_by_permalink(params[:id])
    add_crumb @taper.name, @taper
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @taper }
    end
  end

  # GET /tapers/new
  # GET /tapers/new.xml
  def new
    @taper = Taper.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @taper }
    end
  end

  # GET /tapers/1/edit
  def edit
    @taper = Taper.find_by_permalink(params[:id])
    add_crumb @taper.name, @taper
  end

  # POST /tapers
  # POST /tapers.xml
  def create
    @taper = Taper.new(params[:taper])

    respond_to do |format|
      if @taper.save
        flash[:notice] = 'Taper was successfully created.'
        format.html { redirect_to(@taper) }
        format.xml  { render :xml => @taper, :status => :created, :location => @taper }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @taper.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tapers/1
  # PUT /tapers/1.xml
  def update
    @taper = Taper.find_by_permalink(params[:id])

    respond_to do |format|
      if @taper.update_attributes(params[:taper])
        flash[:notice] = 'Taper was successfully updated.'
        format.html { redirect_to(@taper) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @taper.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tapers/1
  # DELETE /tapers/1.xml
  def destroy
    @taper = Taper.find_by_permalink(params[:id])
    @taper.destroy

    respond_to do |format|
      format.html { redirect_to(tapers_url) }
      format.xml  { head :ok }
    end
  end
end
