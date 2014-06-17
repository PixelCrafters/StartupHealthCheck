PublicActivity::Activity.class_eval do
  scope :organization, -> { where(trackable_type: "Organization").select { |activity| plain_organization?(activity) } }
  scope :tag, -> { where(trackable_type: "Organization").select { |activity| activity.key == ("tag.add" || "tag.remove") } }
  scope :profile_link, -> { where(trackable_type: "ProfileLink") }
  scope :user, -> { where(trackable_type: "User") }
  scope :hiring, -> { where(trackable_type: "Organization").select { |activity| activity.key == ("organization.hiring" || "organization.not_hiring") } }

  def self.combined_distinct
    distinct_organization_distinct_owner + distinct_activities("tag") + distinct_activities("profile_link") + distinct_activities("user") + distinct_activities("hiring")
  end

  def self.distinct_organization_distinct_owner
    organization.uniq { |activity| activity[:owner_id] }
  end

  def self.distinct_activities(type)
    activities = sort_activities(eval(type)).uniq { |activity| activity[:trackable_id] }
    activities.select {|activity| activity.created_at > Date.today - 1.week}
  end

  def self.sort_activities(activities)
    activities.sort_by {|activity| activity.created_at }
  end

  def self.plain_organization?(activity)
    case activity.key
    when "organization.hiring"
      false
    when "organization.not_hiring"
      false
    when "tag.add"
      false
    when"tag.remove"
      false
    else
      true
    end
  end
end
