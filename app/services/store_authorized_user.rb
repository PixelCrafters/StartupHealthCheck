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
    user.create!(attributes)
  end
end

    
