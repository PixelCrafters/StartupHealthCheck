class ProfileLink::Activity::Store
  include Service

  attr_reader :profile_link, :current_user, :type

  def initialize(profile_link, current_user, type)
    @profile_link = profile_link
    @current_user = current_user
    @type = type
  end

  def call
    profile_link.create_activity(
        key: "profile_link.#{type}", 
        owner: current_user, 
        parameters: {
          name: profile_link.name,
          url: profile_link.url, 
          org_name: profile_link.organization.name,
          org_id: profile_link.organization.id
        }
      )
  end
end
