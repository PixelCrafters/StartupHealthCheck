Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    Rails.application.config.auth0_client_id,
    Rails.application.config.auth0_secret,
    Rails.application.config.auth0_domain,
    callback_path: Rails.application.config.auth0_callback_path
  )
end
