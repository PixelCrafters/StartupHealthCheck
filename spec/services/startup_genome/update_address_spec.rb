require 'spec_helper'

describe StartupGenome::UpdateAddress do
  describe "#call" do
    let(:organization) { FactoryGirl.build(:organization) }
    it "should create the address" do
      address = StartupGenome::UpdateAddress.call(ADDRESS_HASH, organization)
      expect(address.persisted?).to eq true
    end

    it "should update the organization" do
      address = StartupGenome::UpdateAddress.call(ADDRESS_HASH, organization)

      hash_dupe = ADDRESS_HASH.dup
      hash_dupe['line1'] = "whatever"

      address = StartupGenome::UpdateAddress.call(hash_dupe, organization)
      expect(address.address1).to eq "whatever"
    end
  end
end
