module StartupGenome
  class PushExistingOrganization
    include Service

    attr_reader :organization

    def initialize(organization)
      @organization = organization
    end

    def call
      response = StartupGenome::API.new.update_organization(organization)
      if success?(response)
        print_msg
        true
      else
        false
      end
    end

    private

    def success?(response)
      response.status == 200
    end

    def print_msg
      puts "Successfully updated #{organization.name} on Startup Genome"
    end
  end
end
