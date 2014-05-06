AUTH0_CONFIG = YAML.load_file("#{::Rails.root}/config/auth0.yml")[::Rails.env]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    'N8s02JgamO99vbx7FOsyS6rJN8nbJMIl',
    'gXwlUlAm-pR-KLEQ8jI3yxFnU3J6sFuzJxDzfIZg3GEJfsCO-rZ4cKe2sYDqiZrM',
    AUTH0_CONFIG['username'] + '.auth0.com',
    callback_path: "/auth/auth0/callback"
  )
end
