module StartupGenome
  class UpdateOrganization
    include Service 

    attr_reader :org_hash

    def initialize(org_hash)
      @org_hash = org_hash
    end

    def call
      data = build_data_hash(org_hash)
      organization = Organization.find_or_initialize_by(startup_genome_id: org_hash["organization_id"])

      msg = organization.update!(data) ? "Successfully created/updated #{org_hash['name']}" : "Failed to update #{org_hash['name']}"
      puts msg

      organization
    end

    private

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
  end
end
