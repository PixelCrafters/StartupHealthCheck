module ApplicationHelper
  def user_is_current_user?
    (current_user.present? && @user == current_user)
  end
end
  
