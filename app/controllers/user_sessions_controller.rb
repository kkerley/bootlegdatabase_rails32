class UserSessionsController < ApplicationController
  
  layout :choose_layout
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
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

  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "Successfully logged out"
    redirect_back_or_default(root_url)
  end




  private
  
  def choose_layout
    (request.xhr?) ? nil : 'application'
  end
  
end
