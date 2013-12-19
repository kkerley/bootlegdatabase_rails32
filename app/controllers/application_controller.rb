# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  filter_parameter_logging :password
  
  
  helper_method :current_user, :current_user_session  
  
  add_crumb "Home", '/'
  
  private  
  def current_user_is_admin?
      return true if current_user.admin?
    end
    
     def require_admin
       if current_user
         unless current_user.admin?
           store_location
           flash[:notice] = "You are not authorized to access this page. Please login using an account with appropriate permissions."
           redirect_to login_path
           return false
         end
       else  
         require_user
         return false
       end
    end
    
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
      
    end
    
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page."
        redirect_to login_path
        return false
      end
    end
  
    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page."
        redirect_to logout_path
        return false
      end
    end
    
   
    
    def store_location 
      session[:return_to] = 
      if request.get? 
        request.request_uri 
      else 
        request.referer 
      end 
    end 
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end