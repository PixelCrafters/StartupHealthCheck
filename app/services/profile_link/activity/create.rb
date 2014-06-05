class ProfileLink::Activity::Create
  include Service

  attr_reader :profile_link, :current_user

  def initialize(profile_link, current_user)
    @profile_link = profile_link
    @current_user = current_user
  end

  def call
    profile_link.create_activity(
        key: "profile_link.create", 
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
