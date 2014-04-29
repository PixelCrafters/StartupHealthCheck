require 'spec_helper'

describe StartupGenome::API do
  let(:sg) { StartupGenome::API.new }

  describe "#get_organizations" do
    it "sends a success response" do
      expect(sg.get_organizations.status).to eq(200) 
    end
  end
end
