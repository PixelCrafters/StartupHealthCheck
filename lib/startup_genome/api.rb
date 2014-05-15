require 'faraday'

module StartupGenome
  class API
    def initialize
      @host = 'http://startupgenome.co/api/'
      @path = 'organizations/city/'
      @auth_code = Rails.application.secrets.startup_genome_auth_code
      @location_slug = Rails.application.config.startup_genome_location_slug
      @conn = APIConnection.connect_via_faraday(@host)

      raise 'You must provide a Startup Genome Authorization Code' if @auth_code.nil?
      raise 'You must provide a Startup Genome Location Slug' if @location_slug.nil?
    end

    def get_organizations
      @conn.get url, {}, {'auth-code' => @auth_code}
    end

    private

    def url
      "#{@host}#{@path}#{@location_slug}"
    end
  end
end 
