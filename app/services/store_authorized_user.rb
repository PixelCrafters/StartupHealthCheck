class StoreAuthorizedUser
  include Service

  attr_reader :userinfo, :claimed_user

  def initialize(userinfo, claimed_user=nil)
    @userinfo = userinfo
    @claimed_user = claimed_user
  end

  def call
    attributes = {
      image: userinfo["info"]["image"],
      email: userinfo["info"]["email"],
      email_verified: userinfo["extra"]["raw_info"]["email_verified"]
    }
    user = ""
    if claimed_user.present?
      user = User.find(claimed_user)
      user.update!(attributes)
    else
      attributes[:name] = userinfo["info"]["name"]
      attributes[:claimed] = true
      user = User.create!(attributes)
    end
    user.create_activity key: "user.create", owner: user
    user
  end
end   
