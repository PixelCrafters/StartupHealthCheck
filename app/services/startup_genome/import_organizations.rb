module StartupGenome
  class ImportOrganizations
    include Service

    def call
      results = StartupGenome::API.new.get_organizations
      persist(JSON.parse(results.body))

      # TODO: Add Completion Summary "Inserted #{x} and updated #{y}"
    end
  
    private

    def persist(orgs)
      orgs.each do |org|
        StartupGenome::StoreOrganization.call(org)
      end
    end
  end
end
