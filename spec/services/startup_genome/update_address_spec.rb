require 'spec_helper'

describe StartupGenome::UpdateAddress do
  describe "#call" do
    let(:organization) { FactoryGirl.build(:organization) }
    it "should create the address" do
      address = StartupGenome::UpdateAddress.call(ORG_HASH, organization)
      expect(address.persisted?).to eq true
    end

    it "should update the organization" do
      address = StartupGenome::UpdateAddress.call(ORG_HASH, organization)

      hash_dupe = ORG_HASH.dup
      hash_dupe['address1'] = "whatever"

      address = StartupGenome::UpdateAddress.call(hash_dupe, organization)
      expect(address.address1).to eq "whatever"
    end
  end
end
