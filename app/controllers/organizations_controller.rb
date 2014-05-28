class OrganizationsController < ApplicationController
  before_filter :check_if_signed_in, only: [:claim, :edit, :toggle_hiring, :destroy_tag, :add_role, :destroy_role]
  before_filter :set_original_url, only: [:add_role, :destroy_role]
  before_filter :find_organization, only: [:show, :claim, :edit, :update, :toggle_hiring, :add_role]

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
        @organization.create_activity key: "organization.claim", owner: current_user
        redirect_to user_path(@organization.users.first)
      else
        redirect_to organization_path(@organization)
      end
      session[:original_url] = nil if session[:original_url]
    end
  end

  def edit
    @profile_link = ProfileLink.new
    @address = @organization.main_address
  end

  def update
    save_tags if params[:organization][:tag_list].present?
    if @organization.update(organization_params)
      flash[:success] = "The organization was updated successfully"
    else
      flash[:error] = "There was a problem updating your organization"
    end
    redirect_to edit_organization_path(@organization)
  end

  def destroy_tag
    organization = Organization.find(params[:organization_id])
    tag = organization.tags.find(params[:tag_id])
    organization.tag_list.remove(tag.name)
    if organization.save!
      organization.create_activity key: "tag.remove", owner: current_user, parameters: {tag_name: tag.name}
      flash[:success] = "The tag was successfully removed"
    else
      flash[:error] = "There was a problem removing your tag"
    end
    redirect_to edit_organization_path(organization)
  end

  def toggle_hiring
    if params[:hiring] == "false"
      @organization.update(hiring: true)
      @organization.create_activity key: "organization.hiring", owner: current_user
    else
      @organization.update(hiring: false)
      @organization.create_activity key: "organization.not_hiring", owner: current_user
    end
    redirect_to edit_organization_path(@organization)
  end

  def add_role
    begin
      CreateOrganizationUserRole.call(params[:role][:id], @organization.id, current_user.id)
      flash[:success] = "Your role was saved successfully!"
    rescue ActiveRecord::RecordNotUnique => e
      role = Role.find(params[:role][:id])
      flash[:error] = "You've already saved the role '#{role.name}' for this organization"
    end
    redirect_to session[:original_url]
  end

  def destroy_role
    if OrganizationUserRole.find(params[:id]).destroy!
      flash[:success] = "Your role was deleted successfully!"
    else
      flash[:success] = "There was a problem deleting your role."
    end
    redirect_to session[:original_url]
  end

  private

  # TODO: extract into service
  def save_tags
    params[:organization][:tag_list].split(',').each do |tag_name|
      if @organization.tag_list.add(tag_name)
        @organization.create_activity key: "tag.add", owner: current_user, parameters: {tag_name: tag_name}
        flash[:success] = "Your tag was saved successfully"
      else
        flash[:error] = "There was a problem saving your tag."
      end
    end
  end

  def find_organization
    @organization = Organization.friendly.find(params[:id])
  end

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

  def set_original_url
    session[:original_url] = request.referrer
  end
end
