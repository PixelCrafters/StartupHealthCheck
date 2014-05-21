class ProfileLinksController < ApplicationController
  def create
    profile_link = ProfileLink.new(profile_link_params)
    name = profile_link.name
    url = profile_link.url
    org = profile_link.organization
    if profile_link.save!
      profile_link.create_activity(
        key: "profile_link.create", 
        owner: current_user, 
        parameters: {
          name: name,
          url: url,
          org_name: org.name,
          org_id: org.id
        }
      )
      flash[:success] = "Your link was created successfully!"
    else
      flash[:error] = "Your link was not created successfully."
    end
    redirect_to edit_organization_path(profile_link.organization)
  end

  def destroy
    profile_link = ProfileLink.find(params[:id])
    name = profile_link.name
    url = profile_link.url
    org = profile_link.organization
    organization = profile_link.organization
    if ProfileLink.destroy(params[:id])
      profile_link.create_activity(
        key: "profile_link.delete", 
        owner: current_user, 
        parameters: {
          name: name,
          url: url, 
          org_name: org.name,
          org_id: org.id
        }
      )
      flash[:success] = "Your link was deleted successfully"
    end
    redirect_to edit_organization_path(organization)
  end

  private

  def profile_link_params
    params.require(:profile_link).permit(:url, :organization_id, :name)
  end
end
