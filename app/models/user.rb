class User < ActiveRecord::Base
  has_many :user_auth_services
  has_and_belongs_to_many :organizations

  def uid(connection)
    user_auth_services.where(service_type: connection, user_id: self.id).first.uid
  end
end
