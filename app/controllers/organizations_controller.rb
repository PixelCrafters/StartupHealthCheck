class OrganizationsController < ApplicationController
  before_filter :check_if_signed_in, only: [:claim, :edit]

  def index
    if params[:query].present?
      results = Organization.search params[:query], {misspellings: false}
      @organizations = results if results.any?
    end
  end

  def show
    @organization = Organization.friendly.find(params[:id])
  end

  #TODO: extract into service
  def claim
    @organization = Organization.friendly.find(params[:id])
    if @organization.claimed?
      redirect_to user_path(current_user)
    else
      @organization.claimed = true
      if @organization.save!
        @organization.users << current_user
        redirect_to user_path(@organization.users.first)
      else
        redirect_to organization_path(@organization)
      end
      session[:original_url] = nil if session[:original_url]
    end
  end

  def edit
    @organization = Organization.friendly.find(params[:id])
    @profile_link = ProfileLink.new
  end

  private

  def organization_params
    params.require(:organization).permit(:claimed, :user_id)
  end

  def check_if_signed_in
    if current_user.nil?
      session[:original_url] = request.original_url
      redirect_to login_path 
      return
    end
  end
end
