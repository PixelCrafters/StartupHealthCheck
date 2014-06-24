class Tag::Destroy
  include Service

  attr_reader :tag_id, :taggable, :current_user

  def initialize(tag_id, taggable, current_user)
    @tag_id = tag_id
    @taggable = taggable
    @current_user = current_user
  end

  def call
    tag = taggable.tags.find(tag_id)
    if taggable.tag_list.remove(tag.name)
      taggable.save
      taggable.create_activity key: "tag.remove", owner: current_user, parameters: {tag_name: tag.name}
      tag
    else
      nil
    end
  end
end
