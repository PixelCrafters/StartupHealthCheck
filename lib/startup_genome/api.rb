require 'faraday'

module StartupGenome
  class API
    def initialize
      @host = 'http://startupgenome.co/api/2/'
      @path = '/organizations'
      @auth_code = Rails.application.config.startup_genome_auth_code
      @location_slug = Rails.application.config.startup_genome_location_slug
      @conn = APIConnection.connect_via_faraday(@host)

      raise 'You must provide a Startup Genome Authorization Code' if @auth_code.nil?
      raise 'You must provide a Startup Genome Location Slug' if @location_slug.nil?
    end

    def get_organizations
      @conn.get url, {}, {'auth-code' => @auth_code}
    end

    def put_organization
      @conn.put 
    end

    private

    def url
      "#{@host}#{@location_slug}#{@path}"
    end

    def organization_url
    end
  end
end 
