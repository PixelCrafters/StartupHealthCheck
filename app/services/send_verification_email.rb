class SendVerificationEmail
  include Service

  attr_reader :email, :connection, :uid

  def initialize(email, connection, uid)
    @email = email
    @connection = connection
    @uid = uid
  end

  def call
    update_email
    results = Auth0::API.new.send_verification_email(email, connection, uid)
    Rails.logger.info "Send Email Verification for #{email}: #(uid), #{connection}: #{results.body}"
  end

  private

  def update_email
    Auth0::API.new.update_email(email, uid)
  end
end
