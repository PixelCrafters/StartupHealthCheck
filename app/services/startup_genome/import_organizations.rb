module StartupGenome
  class ImportOrganizations
    include Service

    def call
      offset = 0
      begin
        results = StartupGenome::API.new.get_organizations(offset)
        persist(JSON.parse(results.body))
        offset = offset + 100
      end while JSON.parse(results.body).count == 100
    end
  
    private

    def persist(orgs)
      orgs.each do |org|
        StartupGenome::StoreOrganization.call(org)
      end
    end
  end
end
