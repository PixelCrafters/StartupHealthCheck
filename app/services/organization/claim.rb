class Organization::Claim
  include Service

  attr_reader :current_user, :organization

  def initialize(current_user, organization)
    @current_user = current_user
    @organization = organization
  end

  def call
    if organization.update(claimed: true)
      organization.users << current_user
      organization.update(admin_id: current_user.id)
      organization.create_activity key: "organization.claim", owner: current_user
    end
    organization
  end
end
