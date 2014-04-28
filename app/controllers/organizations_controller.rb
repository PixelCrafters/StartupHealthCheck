class OrganizationsController < ApplicationController
  def show
    @organization = Organization.friendly.find(params[:id])
  end
end
