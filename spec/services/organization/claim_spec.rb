require 'spec_helper'

describe Organization::Claim do
  describe "#call" do
    let(:current_user) { FactoryGirl.build(:user) }
    it "should claim the organization" do
      organization = FactoryGirl.build(:organization)
      organization = Organization::Claim.call(current_user, organization)
      expect(organization.claimed?).to eq true
    end
  end
end
