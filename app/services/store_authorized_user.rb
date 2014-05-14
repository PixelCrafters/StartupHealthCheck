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
    User.create!(attributes)
  end
end   
