# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  helper_method :admin?
  
  protected
  
  def authorize
    unless admin?
      flash[:error] = "unauthorized access"
      redirect_to root_path
      false
    end
  end
  
  def admin?
    session[:password] == APP_CONFIG['password']
  end
  
end
