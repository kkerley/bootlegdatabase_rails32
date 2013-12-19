class UsersController < ApplicationController
  before_filter :require_admin, :only => [:destroy]
  before_filter :store_location, :only => [:show]
  
  
  layout :choose_layout
  
  add_crumb("Users") { |instance| instance.send :users_path}
  
  def index
    @users = User.paginate :page => params[:page], :order => 'login ASC'
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      respond_to do |wants|
        wants.html do
          flash[:notice] = "Login successful!"
          redirect_back_or_default(root_url)
        end
  
        wants.js { render :redirect }
      end
    else
      respond_to do |wants|
        wants.html { render :new }
        wants.js # create.js.erb
      end
    end
  end

  def show
    @user = User.find_by_permalink!(params[:id])
    add_crumb @user.login, @user
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user  
    if @user.update_attributes(params[:user])  
      flash[:notice] = "Successfully updated profile."  
      redirect_back_or_default(root_url) 
    else  
      render :action => 'edit'  
    end 
  end
  
  def destroy
    @user = User.find_by_permalink!(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  
  #GET /users/1/bootlegs
  def bootlegs
    @user = User.find_by_permalink!(params[:id])
    @bootlegs = @user.bootlegs
  end
  
  
  def add_attendance
    @user = current_user
    @performance = Performance.find_by_permalink(params[:id])
    
    unless @user.was_in_attendance?(@performance)
      #add user to the list using << operator
      @user.performances << @performance
      flash[:notice] = 'You attended this performance'
    else
      flash[:error] = 'You already confirmed your attendance at this performance'
    end
    redirect_back_or_default(root_url)
  end
  
  def remove_attendance
    @user = current_user
    @performance = Performance.find_by_permalink(params[:id])
    
    if @user.was_in_attendance?(@performance)
       @user.performances.delete(@performance)
      
      flash[:notice] = 'You successfully removed yourself from the list of attendees'
    else
      flash[:error] = 'You never attended this show to begin with'
    end
    redirect_back_or_default(root_url)
  end
  
  
  
  # POST /users/1/bootleg_add?bootleg_id=2
  def bootleg_add
    #Convert ids from routing to objects
    @user = current_user
    @recording = Recording.find_by_permalink!(params[:id])
    #@bootleg = Bootleg.find(params[:id])
    
    unless @user.has_already_collected?(@recording)
      #add user to the list using << operator
      @user.recordings << @recording
      flash[:notice] = 'This bootleg was successfully added to your collection'
    else
      flash[:error] = 'This bootleg was already in your collection'
    end
    redirect_back_or_default(root_url)
  end
  
  
  def bootleg_remove
    @user = current_user
    @recording = Recording.find_by_permalink!(params[:id])
    
    
    if @user.has_already_collected?(@recording)
       @user.recordings.delete(@recording)
      
       flash[:notice] = 'This bootleg was successfully removed from your collection'
    else
       flash[:error] = 'This bootleg was not in your collection and therefore cannot be removed'
    end
    redirect_back_or_default(root_url)
  end
  
  
  private
  
  def choose_layout
    (request.xhr?) ? nil : 'application'
  end
  
  
end
