Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    ENV['AUTH0_CLIENT_ID'] || Rails.application.secrets.auth0_client_id,
    ENV['AUTH0_SECRET'] || Rails.application.secrets.auth0_secret,
    ENV['AUTH0_DOMAIN'] || Rails.application.secrets.auth0_domain,
    callback_path: "/auth/auth0/callback"
  )
end
