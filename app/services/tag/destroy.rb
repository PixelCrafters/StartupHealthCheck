class Tag::Destroy
  include Service

  attr_reader :tag_id, :organization, :current_user

  def initialize(tag_id, organization=nil, current_user)
    @tag_id = tag_id
    @organization = organization
    @current_user = current_user
  end

  def call
    if organization.nil?
      destroy_tag(current_user)
    else
      destroy_tag(organization)
    end
  end

  private

  def destroy_tag(obj)
    owner = obj.is_a?(Organization) ? current_user : nil
    tag = obj.tags.find(tag_id)
    if obj.tag_list.remove(tag.name)
      obj.save
      obj.create_activity key: "tag.remove", owner: owner, parameters: {tag_name: tag.name}
      tag
    else
      nil
    end
  end
end
