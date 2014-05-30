class Role < ActiveRecord::Base
  has_many :organization_user_roles
  has_many :organizations
  has_many :users
end
