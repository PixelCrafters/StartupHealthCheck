class SendVerificationEmail
  include Service

  attr_reader :email, :user, :connection

  def initialize(email, user, connection)
    @email = email
    @user = user
    @connection = connection
  end

  def call
    results = Auth0::API.new.update_email(email, user, connection)
    Rails.logger.info "Update Email/Send Email Verification for #{email}: #(uid), #{results.body}"
  end
end
