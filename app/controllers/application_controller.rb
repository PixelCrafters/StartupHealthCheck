class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :check_if_signed_in

  theme "default"
  
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def check_if_signed_in
    if current_user.nil?
      session[:original_url] = request.original_url
      redirect_to login_path 
      return
    end
  end
end
