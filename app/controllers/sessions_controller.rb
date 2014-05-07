class SessionsController < ApplicationController
  def set
    if user = StoreAuthorizedUser.call(session[:userinfo])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash[:error] = "We can't sign you in."
      redirect_to root_path
    end
  end

  def unset
    session[:user_id] = nil
    session[:userinfo] = nil
    redirect_to root_path
  end
end
