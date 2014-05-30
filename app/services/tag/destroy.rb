class Tag::Destroy
  include Service

  attr_reader :tag_id, :organization, :current_user

  def initialize(tag_id, organization, current_user)
    @tag_id = tag_id
    @organization = organization
    @current_user = current_user
  end

  def call
    tag = organization.tags.find(tag_id)
    if organization.tag_list.remove(tag.name)
      organization.save
      organization.create_activity key: "tag.remove", owner: current_user, parameters: {tag_name: tag.name}
      tag
    else
      nil
    end
  end
end
