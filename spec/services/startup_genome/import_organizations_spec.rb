require 'spec_helper'

describe StartupGenome::ImportOrganizations do
  describe "#call" do
    it "imports" do
      VCR.use_cassette 'startup_genome_api_get_organizations' do
        StartupGenome::UpdateOrganization.should_receive(:call).with(any_args()).exactly(100).times
        StartupGenome::ImportOrganizations.call
      end
    end
  end
end
