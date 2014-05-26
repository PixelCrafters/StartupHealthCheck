class User < ActiveRecord::Base
  include PublicActivity::Common

  has_many :organization_role_users
  has_many :roles
  has_many :user_auth_services
  has_and_belongs_to_many :organizations

  def current_roles(organization)
    roles = []
    organization_role_users.each do |oru|
      roles << Role.find(oru.role_id)
    end
    roles
  end
end
