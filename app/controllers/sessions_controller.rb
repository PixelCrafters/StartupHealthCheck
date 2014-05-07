class SessionsController < ApplicationController
  def set
    userinfo = session[:userinfo]
    user_auth_service = StoreUserAuthService.call(userinfo, current_user)
    session[:user_id] = user_auth_service.user.id
    redirect_to user_path(user_auth_service.user)
  end

  def unset
    session[:user_id] = nil
    session[:userinfo] = nil
    redirect_to root_path
  end
end
