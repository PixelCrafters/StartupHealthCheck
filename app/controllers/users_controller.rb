class UsersController < ApplicationController
  before_filter :check_session, only: [:edit, :update, :verify_email]

  def show
    @user = User.find(current_user.id)
  end

  def edit
  end

  def update
    @user = User.find(current_user.id)
    if @user.email.nil? && params[:user][:email].present?

      SendVerificationEmail.call(params[:user][:email], session[:current_connection].downcase, @user.uid(session[:current_connection].downcase))
    end  
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def verify_email_callback
    if current_user.present?
      current_user.email_verified = true
      current_user.save!
    end
    flash[:success] = "Thank you! Your email has been verified."
  end

  private

  def check_session
    redirect_to unset_session_path if session[:expires_at] < Time.current
  end

  def user_params
    params.require(:user).permit(:email, :name)
  end
end
