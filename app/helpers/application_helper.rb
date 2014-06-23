module ApplicationHelper
  def user_is_current_user?
    (current_user.present? && @user == current_user)
  end

  def organization_admin_user?
    current_user && (current_user == @organization.users.first) 
  end
end
  
