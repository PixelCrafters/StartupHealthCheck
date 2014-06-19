class Tag::Create
  include Service

  attr_reader :tag_name, :organization, :current_user

  def initialize(tag_name, organization=nil, current_user)
    @tag_name = tag_name
    @organization = organization
    @current_user = current_user
  end

  def call
    if organization.nil?
      create_tag(current_user)
    else
      create_tag(organization)
    end
  end

  private

  def create_tag(obj)
    owner = obj.is_a?(Organization) ? current_user : nil
    if obj.tag_list.add(tag_name)
      obj.save
      obj.create_activity key: "tag.add", owner: owner, parameters: {tag_name: tag_name}
      obj.tag_list.last
    else
      nil
    end
  end
end
