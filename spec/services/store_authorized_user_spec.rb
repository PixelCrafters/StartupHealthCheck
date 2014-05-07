require 'spec_helper'

describe StoreAuthorizedUser do
  describe "#call" do
    it "should create the user" do
      user = StoreAuthorizedUser.call(USER_INFO_HASH_TWITTER)
      expect(user.persisted?).to eq true
    end

    it "should update the user" do
      user = StoreAuthorizedUser.call(USER_INFO_HASH_TWITTER)

      hash_dupe = USER_INFO_HASH_TWITTER.dup
      hash_dupe["info"]["name"] = "whatever"

      user = StoreAuthorizedUser.call(hash_dupe)
      expect(user.name).to eq "whatever"
    end

    it "should not replace data with nil" do
      user = StoreAuthorizedUser.call(USER_INFO_HASH_TWITTER)

      hash_dupe = USER_INFO_HASH_TWITTER.dup
      hash_dupe["info"]["name"] = nil

      user = StoreAuthorizedUser.call(hash_dupe)
      expect(user.name).to_not be_nil
    end
  end
end
