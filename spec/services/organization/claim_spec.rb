require 'spec_helper'

describe Organization::Claim do
  describe "#call" do
    current_user = FactoryGirl.build(:user)
    organization = FactoryGirl.build(:organization)

    it "should claim the organization" do
      organization = Organization::Claim.call(current_user, organization)
      expect(organization.claimed?).to eq true
    end
  end
end
