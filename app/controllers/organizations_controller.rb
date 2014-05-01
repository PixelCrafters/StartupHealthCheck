class OrganizationsController < ApplicationController
  def index
    if params[:query].present?
      results = Organization.search params[:query], {misspellings: false}
      @organizations = results if results.any?
    end
  end

  def show
    @organization = Organization.friendly.find(params[:id])
  end
end
