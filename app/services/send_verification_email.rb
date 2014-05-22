class SendVerificationEmail
  include Service

  attr_reader :email, :uid

  def initialize(email, uid)
    @email = email
    @uid = uid
  end

  def call
    results = Auth0::API.new.update_email(email, uid)
    Rails.logger.info "Update Email/Send Email Verification for #{email}: #(uid), #{results.body}"
  end
end
