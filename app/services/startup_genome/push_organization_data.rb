module StartupGenome
  class PushOrganizationData
    include Service

    def call
      claimed_orgs = Organization.where(claimed: true)
      push(claimed_orgs)
    end
  
    private

    def push(claimed_orgs)
      claimed_orgs.each do |org|
        if org.updated_last_24_hours? && org.startup_genome_slug.present?
          StartupGenome::PushExistingOrganization.call(org)
        elsif org.created_last_24_hours? && org.startup_genome_slug.nil?
          StartupGenome::PushNewOrganization.call(org)
        end
      end
    end
  end
end
