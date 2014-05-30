class TagsController < ApplicationController
  before_filter :find_organization

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

  private

  def find_organization
    @organization = Organization.find(params[:organization_id])
  end
end
