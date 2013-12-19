class ContactController < ApplicationController
  
  layout :choose_layout
  
  def index
    # render index.html.erb
    add_crumb("Contact")
  end
  
  def create
    if Notifier.deliver_contact(params[:contact])
      # flash[:notice] = "Email was successfully sent"
      # redirect_back_or_default(root_url)
    # else
      # flash.now[:error] = "An error occurred while sending this email"
      # render :index
    # end
    
    respond_to do |wants|
        wants.html do
          flash[:notice] = "Email was successfully sent"
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
  
  
  private
  
  def choose_layout
    (request.xhr?) ? nil : 'application'
  end
  
  
end
