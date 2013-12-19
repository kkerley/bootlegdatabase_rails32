class AddressesController < ApplicationController
  before_filter :require_admin, :only => [:destroy]
  before_filter :require_user, :only => [:new, :create, :edit, :update]
  before_filter :store_location
  
  add_crumb("Addresses") { |instance| instance.send :addresses_path}
  
  layout :choose_layout
  
  # GET /addresses
  # GET /addresses.xml
  def index
    @addresses = Address.paginate :page => params[:page], :order => 'street ASC'
    #@addresses = Address.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @addresses }
    end
  end

  # GET /addresses/1
  # GET /addresses/1.xml
  def show
    # @address = Address.find(params[:id])
    @address = Address.find_by_permalink!(params[:id])
    @address.revert_to(params[:version].to_i) if params[:version]
    add_crumb @address.usable, @address
    
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @address }
    end
  end

  # GET /addresses/new
  # GET /addresses/new.xml
  def new
    @address = Address.new
   

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @address }
    end
  end

  # GET /addresses/1/edit
  def edit
    # @address = Address.find(params[:id])
    @address = Address.find_by_permalink!(params[:id])
    add_crumb @address.usable, @address
  end

  # POST /addresses
  # POST /addresses.xml
  def create
    @address = Address.new(params[:address])
    
    
    # respond_to do |format|
      # if @address.save
        
        # flash[:notice] = 'Address was successfully created.'
        # format.html { redirect_to(@address) }
        # format.xml  { render :xml => @address, :status => :created, :location => @address }
      # else
        # format.html { render :action => "new" }
        # format.xml  { render :xml => @address.errors, :status => :unprocessable_entity }
      # end
    # end
    if @address.save
      respond_to do |wants|
        wants.html do
          flash[:notice] = "Address created successfully!"
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

  # PUT /addresses/1
  # PUT /addresses/1.xml
  def update
    # @address = Address.find(params[:id])
    @address = Address.find_by_permalink!(params[:id])
    
    respond_to do |format|
      if @address.update_attributes(params[:address])
        
        flash[:notice] = 'Address was successfully updated.'
        format.html { redirect_to(@address) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @address.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.xml
  def destroy
    # @address = Address.find(params[:id])
    @address = Address.find_by_permalink!(params[:id])
    @address.destroy

    respond_to do |format|
      format.html { redirect_to(addresses_url) }
      format.xml  { head :ok }
    end
  end
  
  
  private
  
  def choose_layout
    (request.xhr?) ? nil : 'application'
  end
  
end
