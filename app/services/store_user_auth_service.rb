class StoreUserAuthService
  include Service

  attr_reader :userinfo, :current_user, :claimed_user

  def initialize(userinfo, current_user=nil, claimed_user=nil)
    @userinfo = userinfo
    @current_user = current_user
    @claimed_user = claimed_user
  end

  def call
    user_auth_service = UserAuthService.where(uid: userinfo["uid"]).first
    if user_auth_service.nil?
      user_auth_service = UserAuthService.create!(uid: userinfo["uid"], service_type: provider)
    end

    if current_user
      if user_auth_service.user != current_user
        user_auth_service.update!(user: current_user)
      end
    else
      if user_auth_service.user.nil?
        user = StoreAuthorizedUser.call(userinfo, claimed_user)
        user_auth_service.update!(user: user)
      end
    end
    user_auth_service
  end

  private

  def provider
    userinfo["extra"]["raw_info"]["identities"][0]["connection"]
  end
end
