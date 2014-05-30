class User < ActiveRecord::Base
  include PublicActivity::Common

  has_many :organization_user_roles
  has_many :user_auth_services
  has_and_belongs_to_many :organizations

  def uid(connection)
    user_auth_services.where(service_type: connection).first!.uid
  end
  
  def current_roles(organization)
    organization_user_roles.where(organization: organization)
  end
end
