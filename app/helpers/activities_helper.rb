module ActivitiesHelper
  def tag_name(activity)
    activity.parameters[:tag_name] if activity.parameters[:tag_name]
  end
end
