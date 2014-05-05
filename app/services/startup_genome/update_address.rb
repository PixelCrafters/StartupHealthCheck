module StartupGenome
  class UpdateAddress
    include Service

    attr_reader :org_hash, :organization

    def initialize(org_hash, organization)
      @org_hash = org_hash
      @organization = organization
    end

    def call
      update_address(org_hash, organization)
    end

    private

    def update_address(org_hash, organization)
      data = build_address_hash(org_hash)
      address = Address.find_or_initialize_by(organization_id: organization.id)
      msg = address.update!(data) ? "Successfully created/updated address of #{org_hash['name']}" : "Failed to update address of #{org_hash['name']}"
      puts msg
      address
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
