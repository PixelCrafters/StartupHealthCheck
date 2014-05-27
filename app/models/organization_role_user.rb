class OrganizationRoleUser < ActiveRecord::Base
  belongs_to :organization
  belongs_to :role
  belongs_to :user

  self.primary_key = :organization_id 
end
