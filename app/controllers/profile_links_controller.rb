class ProfileLinksController < ApplicationController
  def create
    profile_link = ProfileLink.new(profile_link_params)
    if profile_link.save!
      flash[:success] = "Your link was created successfully!"
    else
      flash[:error] = "Your link was not created successfully."
    end
    redirect_to organization_path(profile_link.organization)
  end

  private

  def profile_link_params
    params.require(:profile_link).permit(:url, :organization_id, :name)
  end
end
