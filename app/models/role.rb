class Role < ActiveRecord::Base
  has_many :organization_role_users
  has_many :organizations
  has_many :users
end
