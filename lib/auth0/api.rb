require 'faraday'

module Auth0
  class API
    def initialize
      @host = "https://" + Rails.application.secrets.auth0_domain
      @auth0_client_id = Rails.application.secrets.auth0_client_id
      @auth0_secret = Rails.application.secrets.auth0_secret
    end

    def access_token
      connect
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

    def send_verification_email(email, connection, uid)
      connect
      @conn.post do |request|
        request.url "api/users/#{URI::encode(uid)}/send_verification_email" 
        request.headers['Authorization'] = 'Bearer ' + access_token
        request.headers['Content-Type'] = 'application/json'
        request.body = {
                        email: email,
                        connection: connection
                       }.to_json
      end
    end

    def update_email(email, uid)
      connect
      @conn.put do |request|
        request.url 'api/users/#{uid}/email'
        request.headers['Authorization'] = 'Bearer ' + access_token
        request.headers['Content-Type'] = 'application/json'
        request.body = {
                        email: email,
                        verify: true
                       }.to_json
      end
    end

    private

    def connect
      @conn = Faraday.new(:url => @host) do |faraday|
        faraday.request  :url_encoded            
        faraday.response :logger                 
        faraday.adapter  Faraday.default_adapter
      end
    end
  end
end 
