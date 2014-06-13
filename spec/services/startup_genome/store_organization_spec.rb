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

    it "should not update a claimed organization" do
      organization = StartupGenome::StoreOrganization.call(ORG_HASH)
      url = organization.url #initial url
      organization.update(claimed: true)

      hash_dupe = ORG_HASH.dup
      hash_dupe['url'] = "whatever"

      organization = StartupGenome::StoreOrganization.call(hash_dupe) #try to update with new url

      expect(organization.url).to eq url
    end
  end
end
