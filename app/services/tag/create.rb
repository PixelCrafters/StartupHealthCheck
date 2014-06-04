class Tag::Create
  include Service

  attr_reader :tag_name, :organization, :current_user

  def initialize(tag_name, organization, current_user)
    @tag_name = tag_name
    @organization = organization
    @current_user = current_user
  end

  def call
    if organization.tag_list.add(tag_name)
      organization.save
      Organization.reindex
      organization.create_activity key: "tag.add", owner: current_user, parameters: {tag_name: tag_name}
      organization.tag_list.last
    else
      nil
    end
  end
end
