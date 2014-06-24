class Tag::Create
  include Service

  attr_reader :tag_name, :taggable, :current_user

  def initialize(tag_name, taggable, current_user)
    @tag_name = tag_name
    @taggable = taggable
    @current_user = current_user
  end

  def call
    if taggable.tag_list.add(tag_name)
      taggable.save
      taggable.create_activity key: "tag.add", owner: current_user, parameters: {tag_name: tag_name}
      taggable.tag_list.last
    else
      nil
    end
  end
end
