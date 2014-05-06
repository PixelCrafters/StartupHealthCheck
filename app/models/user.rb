class User < ActiveRecord::Base
  has_many :user_auth_services
end
