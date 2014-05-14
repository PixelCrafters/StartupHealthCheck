class OrganizationsController < ApplicationController
  before_filter :check_if_signed_in, only: [:claim, :edit]
  before_filter :find_organization, only: [:show, :claim, :edit, :update]

  def index
    if params[:query].present?
      results = Organization.search params[:query], {misspellings: false}
      @organizations = results if results.any?
    elsif params[:tag].present?
      @organizations = Organization.tagged_with(params[:tag])
    end
  end

  def show
  end

  #TODO: extract into service
  def claim
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
    @profile_link = ProfileLink.new
  end

  def update
    if @organization.update(organization_params)
      flash[:success] = "Your tag(s) were added successfully!"
    else
      flash[:error] = "There was a problem adding your tag(s)."
    end
    redirect_to edit_organization_path(@organization)
  end

  private

  def find_organization
    @organization = Organization.friendly.find(params[:id])
  end

  def organization_params
    params.require(:organization).permit(:claimed, :user_id, :tag_list)
  end

  def check_if_signed_in
    if current_user.nil?
      session[:original_url] = request.original_url
      redirect_to login_path 
      return
    end
  end
end
