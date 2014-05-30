class OrganizationUserRole::Create
  include Service

  attr_reader :role_id, :organization_id, :user_id

  def initialize(role_id, organization_id, user_id)
    @role_id = role_id
    @organization_id = organization_id
    @user_id = user_id
  end

  def call
    role = Role.find(role_id)
    OrganizationUserRole.create!(
      organization_id: organization_id, 
      user_id: user_id, 
      role_id: role_id
    )
  end
end
