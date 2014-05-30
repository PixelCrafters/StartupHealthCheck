class Auth0Controller < ApplicationController
  def callback
    session[:userinfo] = env.fetch('omniauth.auth')
    redirect_to set_session_path
  end

  def verify_email_callback
    if params[:success] == "true"
      flash[:success] = "Thank you! Your email has been verified."
    else
      flash[:error] = "There was a problem verifying your email."
    end

    redirect_to root_url
  end
end
