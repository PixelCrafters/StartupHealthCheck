require 'faraday'

module StartupGenome
  class API
    def initialize
      @host = 'http://startupgenome.co/api/2/'
      @path = '/organizations'
      @auth_code = ENV['STARTUP_GENOME_AUTH_CODE'] || Rails.application.secrets.startup_genome_auth_code
      @location_slug = ENV['STARTUP_GENOME_LOCATION_SLUG'] || Rails.application.secrets.startup_genome_location_slug
      @conn = APIConnection.connect_via_faraday(@host)

      raise 'You must provide a Startup Genome Authorization Code' if @auth_code.nil?
      raise 'You must provide a Startup Genome Location Slug' if @location_slug.nil?
    end

    def get_organizations
      @conn.get url, {}, {'auth-code' => @auth_code}
    end

    private

    def url
      "#{@host}#{@location_slug}#{@path}"
    end
  end
end 
