require 'spec_helper'

describe StartupGenome::ImportOrganizationData do

  describe "#call" do

    it "imports" do
      VCR.use_cassette 'startup_genome_api_get_organizations' do
        StartupGenome::UpdateOrganization.should_receive(:call).with(any_args()).exactly(429).times
        StartupGenome::ImportOrganizationData.call
      end
    end

  end

end
