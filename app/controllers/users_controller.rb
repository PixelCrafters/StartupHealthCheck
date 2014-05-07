class UsersController < ApplicationController
  def show
  end

  def edit
  end

  def update
    @user = User.find(current_user.id)
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:email, :name)
  end
end
