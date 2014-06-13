require 'spec_helper'

describe StartupGenome::StoreOrganization do
  describe "#call" do
    it "should create the organization" do
      organization = StartupGenome::StoreOrganization.call(ORG_HASH)
      expect(organization.persisted?).to eq true
    end

    it "should update the organization" do
      organization = StartupGenome::StoreOrganization.call(ORG_HASH)

      hash_dupe = ORG_HASH.dup
      hash_dupe['url'] = "whatever"

      organization = StartupGenome::StoreOrganization.call(hash_dupe)
      expect(organization.url).to eq "whatever"
    end
  end
end
