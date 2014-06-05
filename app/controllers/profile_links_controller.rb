class ProfileLinksController < ApplicationController
  def create
    profile_link = ProfileLink.new(profile_link_params)
    if profile_link.save
      ProfileLink::Activity::Store.call(profile_link, current_user, "create")
      flash[:success] = "Your link was created successfully!"
    else
      flash[:error] = "Your link was not created successfully."
    end
    redirect_to edit_organization_path(profile_link.organization)
  end

  def destroy
    profile_link = ProfileLink.find(params[:id])
    if ProfileLink.destroy(params[:id])
      ProfileLink::Activity::Store.call(profile_link, current_user, "delete")
      flash[:success] = "Your link was deleted successfully"
    end
    redirect_to edit_organization_path(profile_link.organization)
  end

  private

  def profile_link_params
    params.require(:profile_link).permit(:url, :organization_id, :name)
  end
end
