class TagsController < ApplicationController
  before_filter :check_if_signed_in
  before_filter :find_organization, only: [:create, :destroy]

  def create
    params[:tag_list].split(',').each do |tag_name|
      if Tag::Create.call(tag_name, @organization, current_user)
        flash[:success] = "Your tag was saved successfully"
      else
        flash[:error] = "There was a problem saving your tag."
      end
    end
    redirect_to edit_organization_path(@organization)
  end

  def destroy
    if Tag::Destroy.call(params[:tag_id], @organization, current_user)
      flash[:success] = "The tag was successfully removed"
    else
      flash[:error] = "There was a problem removing your tag"
    end
    redirect_to edit_organization_path(@organization)
  end

  def create_user_tag
    params[:tag_list].split(',').each do |tag_name|
      if Tag::Create.call(tag_name, current_user, current_user)
        flash[:success] = "Your tag was saved successfully"
      else
        flash[:error] = "There was a problem saving your tag."
      end
    end
    redirect_to edit_user_path(current_user)
  end

  def destroy_user_tag
    if Tag::Destroy.call(params[:tag_id], current_user, current_user)
      flash[:success] = "The tag was successfully removed"
    else
      flash[:error] = "There was a problem removing your tag"
    end
    redirect_to edit_user_path(current_user)
  end

  private

  def find_organization
    @organization = Organization.find(params[:organization_id])
  end
end
