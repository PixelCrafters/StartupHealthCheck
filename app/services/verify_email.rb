class VerifyEmail
  include Service

  attr_reader :email, :uid

  def initialize(email, uid)
    @email = email
    @uid = uid
  end

  def call
    results = Auth0::API.new.verify_email(email, uid)
    Rails.logger.info "Email Verification attempt for #{email}, #{uid}: #{results.body}"
  end
end
