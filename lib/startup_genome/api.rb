require 'faraday'

module StartupGenome
  class API
    def initialize
      @host = 'http://startupgenome.co/api/2/'
      @auth_code = Rails.application.secrets.startup_genome_auth_code
      @location_slug = Rails.application.secrets.startup_genome_location_slug
      @conn = APIConnection.connect_via_faraday(@host)

      raise 'You must provide a Startup Genome Authorization Code' if @auth_code.nil?
      raise 'You must provide a Startup Genome Location Slug' if @location_slug.nil?
    end

    def get_organizations
      @conn.get organizations_url, {}, {'auth-code' => @auth_code}
    end

    def get_people
      @conn.get people_url, {}, {'auth-code' => @auth_code}
    end

    def update_organization(organization)
      response = @conn.put do |req|
        req.url organization.startup_genome_slug
        req.headers['auth-code'] = @auth_code
        req.body = organization_payload(organization)
      end
      Rails.logger.info "SG Update Organization Response: #{response.inspect}"
      response
    end

    def new_organization(organization)
      return if slug_unavailable(organization)
      response = @conn.post do |req|
        req.url organization.slug
        req.headers['auth-code'] = @auth_code
        req.body = organization_payload(organization)
      end
      organization.update(startup_genome_slug: organization.slug) if response.status == 200
      Rails.logger.info "SG New Organization Response: #{response.inspect}"
      response
    end

    private

    def organizations_url
      path = '/organizations'
      "#{@host}#{@location_slug}#{path}"
    end

    def people_url
      path = '/people'
      "#{@host}#{@location_slug}#{path}"
    end

    # fields added here should match the structure expected by Startup Genome
    # see spec/support/org_hash.rb for an example
    def organization_payload(organization)
      {
        type: 'organization',
        name: organization.name,
        description: organization.description
      }
    end

    def slug_unavailable(organization)
      response = @conn.get organization.slug, {}, {'auth-code' => @auth_code}
      if response.status != 404
        true
      else
        false
      end
    end
  end
end 
