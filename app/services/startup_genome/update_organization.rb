module StartupGenome
  class UpdateOrganization
    include Service 

    attr_reader :org_hash

    def initialize(org_hash)
      @org_hash = org_hash
    end

    def call
      update_organization(org_hash)
    end

    private

    def update_organization(org_hash)
      data = build_data_hash(org_hash)
      organization = Organization.find_or_initialize_by(startup_genome_id: org_hash["organization_id"])
      msg = organization.update!(data) ? "Successfully created/updated #{org_hash['name']}" : "Failed to update #{org_hash['name']}"
      puts msg
      update_address(org_hash, organization)
      organization
    end

    # TODO: Extract this out into it's own service
    def update_address(org_hash, organization)
      data = build_address_hash(org_hash)
      address = Address.find_or_initialize_by(organization_id: organization.id)
      msg = address.update!(data) ? "Successfully created/updated address of #{org_hash['name']}" : "Failed to update address of #{org_hash['name']}"
      puts msg
    end

    def build_data_hash(org_hash)
      { name: org_hash["name"],
        headline: org_hash["headline"],
        description: org_hash["description"],
        hiring_url: org_hash["hiring_url"], 
        active: org_hash["active"],
        approved: org_hash["approved"],
        startup_genome_slug: org_hash["slug"],
        url: org_hash["url"],
        founded: org_hash["founded"].to_i,
        startup_genome_id: org_hash["organization_id"] }
    end

    def build_address_hash(org_hash)
      { latitude: org_hash["latitude"],
        longitude: org_hash["longitude"],
        zip: org_hash["zip"],
        address1: org_hash["address1"], 
        address2: org_hash["address2"],
        state: org_hash["state"],
        country: org_hash["country"] }
    end
  end
end
