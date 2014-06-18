class SessionsController < ApplicationController
  def set
    userinfo = session[:userinfo]
    claimed_user = session[:claimed_user_id]
    user_auth_service = StoreUserAuthService.call(userinfo, current_user, claimed_user)
    set_session_variables(user_auth_service)
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

  private

  def set_session_variables(user_auth_service)
    session[:user_id] = user_auth_service.user.id
    session[:expires_at] = Time.current + 2.hours
    session[:current_connection] = user_auth_service.service_type
  end
end
