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
      email: userinfo["info"]["email"]
    }
    user = User.create!(attributes)
    user.create_activity key: "user.create", owner: user
    user
  end
end   
