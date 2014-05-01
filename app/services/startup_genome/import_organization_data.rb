module StartupGenome
  class ImportOrganizationData
    include Service

    def call
      results = StartupGenome::API.new.get_organizations
      persist(JSON.parse(results.body))

     # TODO: Add Completion Summary "Inserted #{x} and updated #{y}"
    end
  
    private

    def persist(orgs)
      orgs['response'].each do |org|
        StartupGenome::UpdateOrganization.call(org[1])
      end
    end
  end
end
