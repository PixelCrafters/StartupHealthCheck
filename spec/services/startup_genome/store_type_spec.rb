require 'spec_helper'

describe StartupGenome::StoreType do
  describe "#call" do
    let(:organization) { FactoryGirl.build(:organization) }
    it "should add the type to the organization" do
      type = StartupGenome::StoreType.call(TYPE_HASH, organization)
      expect(organization.types.last).to eq type
    end
  end
end
