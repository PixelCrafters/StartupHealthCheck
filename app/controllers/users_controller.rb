class UsersController < ApplicationController
  before_filter :check_session, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    @user = User.find(current_user.id)
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  private

  def check_session
    redirect_to unset_session_path if session[:expires_at] < Time.current
  end

  def user_params
    params.require(:user).permit(:email, :name)
  end
end
