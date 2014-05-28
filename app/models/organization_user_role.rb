class OrganizationUserRole < ActiveRecord::Base
  belongs_to :organization
  belongs_to :role
  belongs_to :user

  def name
    role.name
  end
end
