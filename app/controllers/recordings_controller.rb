class RecordingsController < ApplicationController
  before_filter :require_admin, :only => [:destroy]
  before_filter :require_user, :only => [:new, :create, :edit, :update]
  before_filter :store_location  
  
  add_crumb("Recordings") { |instance| instance.send :recordings_path}
  
  # GET /recordings
  # GET /recordings.xml
  def index
    @recordings = Recording.paginate :page => params[:page], :order => 'permalink DESC'
    #@recordings = Recording.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @recordings }
    end
  end

  # GET /recordings/1
  # GET /recordings/1.xml
  def show
    @recording = Recording.find_by_permalink(params[:id])
    @collectors = @recording.users
    @recording.revert_to(params[:version].to_i) if params[:version]
    add_crumb @recording.performance.compact_with_band + " " + @recording.recording_format + " taped by " + @recording.taper.name, @recording
  
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @recording }
    end
  end

  # GET /recordings/new
  # GET /recordings/new.xml
  def new
    @recording = Recording.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @recording }
    end
  end

  # GET /recordings/1/edit
  def edit
    @recording = Recording.find_by_permalink(params[:id])
  end

  # POST /recordings
  # POST /recordings.xml
  def create
    @recording = Recording.new(params[:recording])

    respond_to do |format|
      if @recording.save
        flash[:notice] = 'Recording was successfully created.'
        format.html { redirect_to(@recording) }
        format.xml  { render :xml => @recording, :status => :created, :location => @recording }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @recording.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /recordings/1
  # PUT /recordings/1.xml
  def update
    @recording = Recording.find_by_permalink(params[:id])

    respond_to do |format|
      if @recording.update_attributes(params[:recording])
        flash[:notice] = 'Recording was successfully updated.'
        format.html { redirect_to(@recording) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @recording.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /recordings/1
  # DELETE /recordings/1.xml
  def destroy
    @recording = Recording.find_by_permalink(params[:id])
    @recording.destroy

    respond_to do |format|
      format.html { redirect_to(recordings_url) }
      format.xml  { head :ok }
    end
  end
  
end
