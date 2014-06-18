require 'spec_helper'

describe StartupGenome::ImportPeople do
  describe "#call" do
    it "imports" do
      VCR.use_cassette 'startup_genome_api_get_people' do
        StartupGenome::StoreUser.should_receive(:call).with(any_args()).exactly(100).times
        StartupGenome::ImportPeople.call
      end
    end
  end
end
