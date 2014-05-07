class CreateAuthorizedUser
  include Service

  attr_reader :userinfo

  def initialize(userinfo)
    @userinfo = userinfo
  end

  def call
    auth_service = UserAuthService.find_or_initialize_by(uid: userinfo["uid"])
    auth0_client_id = get_auth0_client_id
    if auth_service.user.nil?
      user = get_user
      auth_service.update(service_type: get_service_type)
      user.user_auth_services << auth_service
    end
    store_user_info(auth_service.user)
    raise "Could not create user" if auth_service.user.nil?
    auth_service.user
  end

  private

  def get_user
    User.find_or_create_by(
      auth0_client_id: get_auth0_client_id
      )
  end

  # Don't replace previously persisted data with nil, but store new bits
  def store_user_info(user)
    attributes = {
      name: userinfo["info"]["name"], 
      image: userinfo["info"]["image"],
      email: userinfo["info"]["email"]
    }
    user.update(attributes.select{|k,v| !v.nil?})
  end

  def get_service_type
    userinfo["extra"]["raw_info"]["identities"][0]["connection"]
  end

  def get_auth0_client_id
    userinfo["extra"]["raw_info"]["clientID"]
  end
end
