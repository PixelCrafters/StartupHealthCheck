class Organization::Create
  include Service

  attr_reader :params, :current_user

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def call
    @organization = Organization.create(params)
    if @organization.persisted?
      @organization.users << current_user
      @organization.create_activity key: "organization.create"
    end
    @organization
  end
end
