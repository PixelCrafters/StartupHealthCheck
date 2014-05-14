class SendVerificationEmail
  include Service

  attr_reader :email, :connection

  def initialize(email, connection)
    @email = email
    @connection = connection
  end

  def call
    results = Auth0::API.new.send_verification_email(email, connection)
    Rails.logger.info "Send Email Verification for #{email}, #{connection}: #{results.body}"
  end
end
