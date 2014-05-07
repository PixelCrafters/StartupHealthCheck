require 'spec_helper'

describe StoreAuthorizedUser do
  describe "#call" do
    it "should create the user" do
      user = StoreAuthorizedUser.call(USER_INFO_HASH_TWITTER)
      expect(user.persisted?).to eq true
    end
  end
end
