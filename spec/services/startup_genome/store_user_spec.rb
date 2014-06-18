require 'spec_helper'

describe StartupGenome::StoreUser do
  describe "#call" do
    it "should create the user" do
      user = StartupGenome::StoreUser.call(PERSON_HASH)
      expect(user.persisted?).to eq true
    end

    it "should update the user" do
      user = StartupGenome::StoreUser.call(PERSON_HASH)

      hash_dupe = PERSON_HASH.dup
      hash_dupe['url'] = "whatever"

      user = StartupGenome::StoreUser.call(hash_dupe)
      expect(user.startup_genome_url).to eq "whatever"
    end
  end
end
