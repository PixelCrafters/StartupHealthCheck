require 'faraday'

module Auth0
  class API
    def initialize
      @host = "https://" + Rails.application.secrets.auth0_domain
      @auth0_client_id = Rails.application.secrets.auth0_client_id
      @auth0_secret = Rails.application.secrets.auth0_secret
      @conn = APIConnection.connect_via_faraday(@host)
    end

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
  end
end 
