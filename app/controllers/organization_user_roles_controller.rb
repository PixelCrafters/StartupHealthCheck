class OrganizationUserRolesController < ApplicationController
  before_filter :set_original_url
  before_filter :find_organization
  after_filter :unset_original_url

  def create
    begin
      OrganizationUserRole::Create.call(params[:role][:id], @organization.id, current_user.id)
      flash[:success] = "Your role was saved successfully!"
    rescue ActiveRecord::RecordNotUnique => e
      role = Role.find(params[:role][:id])
      flash[:error] = "You've already saved the role '#{role.name}' for this organization"
    end
    redirect_to session[:original_url]
  end

  def destroy
    if OrganizationUserRole.find(params[:id]).destroy!
      flash[:success] = "Your role was deleted successfully!"
    else
      flash[:success] = "There was a problem deleting your role."
    end
    redirect_to session[:original_url]
  end

  private

  def find_organization
    @organization = Organization.find(params[:organization_id])
  end
end
