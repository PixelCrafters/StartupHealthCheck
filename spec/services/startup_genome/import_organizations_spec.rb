require 'spec_helper'

describe StartupGenome::ImportOrganizations do
  describe "#call" do
    it "imports" do
      VCR.use_cassette 'startup_genome_api_get_organizations' do
        StartupGenome::StoreOrganization.should_receive(:call).with(any_args()).exactly(550).times
        StartupGenome::ImportOrganizations.call
      end
    end
  end
end

def get_organizations_uri(offset)
  "http://startupgenome.co/api/2/vancouver-britishcolumbia-can/organizations?offset=#{offset}"
end
