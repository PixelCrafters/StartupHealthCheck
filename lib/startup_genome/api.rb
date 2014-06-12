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
      @conn.get url, {}, auth_code_header
    end

    def update_organization(organization)
      slug = organization.startup_genome_slug
      url = @host + slug
      @conn.put url, organization_payload(organization), auth_code_header
    end

    def new_organization(organization)
      url = @host + organization.slug
      puts "***********URL: #{url}"
      return if slug_unavailable(organization, url)
      response = @conn.post url, organization_payload(organization), auth_code_header
      Rails.logger.debug "Post Response: #{response.inspect}"
    end

    private

    def url
      "#{@host}#{@location_slug}#{@path}"
    end

    def organization_payload(organization)
      {
        "type" => "organization",
        "description" => organization.description
      }.to_json
    end

    def auth_code_header
      {'auth-code' => @auth_code}
    end

    def slug_unavailable(organization, url)
      response = @conn.get url, {}, auth_code_header
      body = JSON.parse(response.body)
      puts "***********Slug Available? Response #{response.inspect}"
      if body["error"] != "404"
        true
      else
        false
      end
    end
  end
end 
