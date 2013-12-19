class PerformersController < ApplicationController
  before_filter :require_admin, :only => [:destroy]
  before_filter :require_user, :only => [:new, :create, :edit, :update]
  before_filter :store_location
  
  add_crumb("Performers"){|instance| instance.send :performers_path}
  
  # GET /performers
  # GET /performers.xml
  def index
    @performers = Performer.paginate :page => params[:page], :order => 'first_name ASC'
    #@performers = Performer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @performers }
    end
  end

  # GET /performers/1
  # GET /performers/1.xml
  def show
    # @performer = Performer.find(params[:id])
    @performer = Performer.find_by_permalink!(params[:id])
    @performer.revert_to(params[:version].to_i) if params[:version]
    add_crumb @performer.name, @performer
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @performer }
    end
  end

  # GET /performers/new
  # GET /performers/new.xml
  def new
    @performer = Performer.new
    # @all_performers = Performer.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @performer }
    end
  end

  # GET /performers/1/edit
  def edit
    #@performer = Performer.find(params[:id])
    @performer = Performer.find_by_permalink!(params[:id])
    add_crumb @performer.name, @performer
  end

  # POST /performers
  # POST /performers.xml
  def create
    @performer = Performer.new(params[:performer])
    @performer.create_permalink

    respond_to do |format|
      if @performer.save
        flash[:notice] = 'Performer was successfully created.'
        format.html { redirect_to bands_performer_path(@performer) }
        format.xml  { render :xml => @performer, :status => :created, :location => @performer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @performer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /performers/1
  # PUT /performers/1.xml
  def update
    # @performer = Performer.find(params[:id])
    @performer = Performer.find_by_permalink!(params[:id])

    respond_to do |format|
      if @performer.update_attributes(params[:performer])
        flash[:notice] = 'Performer was successfully updated.'
        format.html { redirect_to(@performer) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @performer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /performers/1
  # DELETE /performers/1.xml
  def destroy
    # @performer = Performer.find(params[:id])
    @performer = Performer.find_by_permalink!(params[:id])
    @performer.destroy

    respond_to do |format|
      format.html { redirect_to(performers_url) }
      format.xml  { head :ok }
    end
  end
  
  # GET /performers/1/bands
  def bands
    #@performer = Performer.find(params[:id])
    @performer = Performer.find_by_permalink!(params[:id])
    @bands = @performer.bands
  end
  
  def band_add
    #@performer = Performer.find(params[:id])
    @performer = Performer.find_by_permalink!(params[:id])
    @band = Band.find(params[:band])
    
    unless @performer.member_of?(@band)
      @performer.bands << @band
      flash[:notice] = "Successfully added as a band member."
    else
      flash[:error] = "Performer was already a band member."
    end
    redirect_to :action => :bands, :id => @performer
  end
  
  def band_remove
    # @performer = Performer.find(params[:id])
    @performer = Performer.find_by_permalink!(params[:id])
    
    band_ids = params[:bands]
    
    unless band_ids.blank?
      band_ids.each do |band_id|
        band = Band.find(band_id)
        if @performer.member_of?(band)
          @performer.bands.delete(band)
          flash[:notice] = "No longer a band member."
        end
      end
    end
    redirect_to :action => :bands, :id => @performer
  end
end