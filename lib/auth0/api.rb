require 'faraday'

module Auth0
  class API
    def initialize
      @host = "https://" + (ENV['AUTH0_DOMAIN'] || Rails.application.secrets.auth0_domain)
      @auth0_client_id =  ENV['AUTH0_CLIENT_ID'] || Rails.application.secrets.auth0_client_id
      @auth0_secret =  ENV['AUTH0_SECRET'] ||  Rails.application.secrets.auth0_secret
      @conn = APIConnection.connect_via_faraday(@host)
    end

    def update_email(email, user, connection)
      uid = User.find(user.id).uid(connection)
      @conn.put do |request|
        request.url "api/users/#{uid.gsub!('|','%7C')}/email"
        request.headers['Authorization'] = 'Bearer ' + access_token
        request.headers['Content-Type'] = 'application/json'
        request.body = {
                        email: email,
                        verify: true
                       }.to_json
      end
    end

    private

    def access_token
      response = @conn.post do |request|
        request.url 'oauth/token' 
        request.headers['Content-Type'] = 'application/json'
        request.body = {
                        client_id: @auth0_client_id,
                        client_secret: @auth0_secret,
                        grant_type: 'client_credentials'
                       }.to_json
      end
      JSON.parse(response.body)["access_token"]
    end
  end
end 
