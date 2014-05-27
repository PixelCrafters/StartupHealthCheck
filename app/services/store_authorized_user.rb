class StoreAuthorizedUser
  include Service

  attr_reader :userinfo

  def initialize(userinfo)
    @userinfo = userinfo
  end

  def call
    attributes = {
      name: userinfo["info"]["name"], 
      image: userinfo["info"]["image"],
      email: userinfo["info"]["email"],
      email_verified: userinfo["extra"]["raw_info"]["email_verified"]
    }
    user = User.find_or_initialize_by(email: userinfo["info"]["email"])
    user.update!(attributes)
    user.create_activity key: "user.create", owner: user
    user
  end
end   
