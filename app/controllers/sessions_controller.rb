class SessionsController < ApplicationController
  def set
    userinfo = session[:userinfo]
    user_auth_service = StoreUserAuthService.call(userinfo, current_user)
    session[:user_id] = user_auth_service.user.id
    session[:expires_at] = Time.current + 2.hours
    session[:current_connection] = user_auth_service.service_type
    if session[:original_url]
      redirect_to session[:original_url]
    else
      redirect_to user_path(user_auth_service.user)
    end
  end

  def unset
    session[:user_id] = nil
    session[:userinfo] = nil
    session[:current_connection] = nil
    redirect_to root_path
  end
end
