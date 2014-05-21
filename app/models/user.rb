class User < ActiveRecord::Base
  include PublicActivity::Common

  has_many :user_auth_services
  has_and_belongs_to_many :organizations
end
