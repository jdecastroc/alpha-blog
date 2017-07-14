class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #This makes the following methods available to use in the views
  helper_method :current_user, :logged_in?
  
  #Get the info of the logged user
  def current_user
    # Return the OBJECT user if the session exist (Only 1 hit)
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  #Check whether a user has been logged
  def logged_in?
    #Transform the current_user var into boolean
    !!current_user
  end
  
  #Check whether a user has been logged and perform a safe action
  # Used to restrict the controller actions (before_actions)
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
end
