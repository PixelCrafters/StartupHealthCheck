require 'spec_helper'

describe StartupGenome::PushOrganizationData do
  describe "#call" do
    it "updates organizations on startup genome" do
      organization = FactoryGirl.create(:organization, name: "Brewhouse", claimed: true, startup_genome_slug: "brewhouse", description: "Dedicated to building superb software. Our office is located in the heart of Vancouver's historic Gastown district. Stop by for a cup of coffee sometime.")
      VCR.use_cassette 'startup_genome_api_update_organization' do
        StartupGenome::PushExistingOrganization.should_receive(:call).with(organization).exactly(1).times
        StartupGenome::PushOrganizationData.call
      end
    end

    it "adds organizations on startup genome" do
      new_organization = FactoryGirl.create(:organization, name: "Brewhouse", claimed: true, description: "Dedicated to building superb software. Our office is located in the heart of Vancouver's historic Gastown district. Stop by for a cup of coffee sometime.")
      VCR.use_cassette 'startup_genome_api_new_organization' do
        StartupGenome::PushNewOrganization.should_receive(:call).with(new_organization).exactly(1).times
        StartupGenome::PushOrganizationData.call
      end
    end
  end
end
