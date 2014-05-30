class OrganizationsController < ApplicationController  
  before_filter :check_if_signed_in, only: [:claim, :edit, :toggle_hiring, :destroy_tag, :add_role, :destroy_role]
  before_filter :set_original_url, only: [:add_role, :destroy_role]
  after_filter :unset_original_url, only: [:claim, :add_role, :destroy_role]
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

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization::Create.call(organization_params, current_user)
    if @organization.persisted?
      flash[:success] = "The organization was added successfully"
    else
      flash[:error] = "There was a problem adding your organization"
    end
    redirect_to edit_organization_path(@organization)
  end

  def claim
    if @organization.claimed?
      redirect_to user_path(@organization, current_user)
    else
      @organization = Organization::Claim.call(current_user, @organization)
      if @organization.claimed?
        redirect_to user_path(current_user)
      else
        redirect_to organization_path(@organization)
      end
    end
  end

  def edit
    @profile_link = ProfileLink.new
    @organization.main_address ? @address = @organization.main_address : @address = Address.new
  end

  def update
    if @organization.update!(organization_params)
      flash[:success] = "The organization was updated successfully"
    else
      flash[:error] = "There was a problem updating your organization"
    end
    redirect_to edit_organization_path(@organization)
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

  def find_organization
    @organization = Organization.friendly.find(params[:id])
  end

  def organization_params
    params.require(:organization).permit(:claimed, :user_id, :headline, :description, :name)
  end

  def set_original_url
    session[:original_url] = request.referrer
  end

  def unset_original_url
    session[:original_url] = nil
  end
end
