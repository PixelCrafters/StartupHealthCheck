class Organization::Create
  include Service

  attr_reader :params, :current_user

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def call
    organization = Organization.new(params)

    Organization.transaction do
      if organization.save
        organization.users << current_user
        organization.create_activity key: "organization.create", parameters: {org_name: organization.name}
      end
    end

    organization
  end
end
