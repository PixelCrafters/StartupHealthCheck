Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    Rails.application.secrets.auth0_client_id,
    Rails.application.secrets.auth0_secret,
    Rails.application.secrets.auth0_domain,
    callback_path: "/auth/auth0/callback"
  )
end
