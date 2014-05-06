class CreateAuthorizedUser
  include Service

  attr_reader :userinfo

  def initialize(userinfo)
    @userinfo = userinfo
  end

  def call
    auth_service = UserAuthService.find_or_initialize_by(uid: userinfo["uid"])
    auth0_client_id = userinfo["extra"]["raw_info"]["clientID"]
    if auth_service.user.nil?
      user = User.find_or_create_by(auth0_client_id: auth0_client_id)
      auth_service.update(service_type: userinfo["extra"]["raw_info"]["identities"][0]["connection"])
      user.user_auth_services << auth_service
    end
    raise "Could not create user" if auth_service.user.nil?
    auth_service.user
  end
end
