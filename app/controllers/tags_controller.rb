class TagsController < ApplicationController
  before_filter :find_organization

  def create
    params[:tag_list].split(',').each do |tag_name|
      if @organization.tag_list.add(tag_name)
        @organization.save
        @organization.create_activity key: "tag.add", owner: current_user, parameters: {tag_name: tag_name}
        flash[:success] = "Your tag was saved successfully"
      else
        flash[:error] = "There was a problem saving your tag."
      end
    end
    redirect_to edit_organization_path(@organization)
  end

  def destroy
    tag = @organization.tags.find(params[:tag_id])
    if @organization.tag_list.remove(tag.name)
      @organization.save
      @organization.create_activity key: "tag.remove", owner: current_user, parameters: {tag_name: tag.name}
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
