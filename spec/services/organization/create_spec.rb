require 'spec_helper'

describe Organization::Create do
  describe "#call" do
    let(:current_user) { FactoryGirl.build(:user) }
    params = {
      "claimed"=>"true",
      "headline"=>"MyCompany headline",
      "description"=>"The description of MyCompany",
      "name"=>"MyCompany"
    }
    it "should create the organization" do
      organization = Organization::Create.call(params, current_user)
      expect(organization.persisted?).to eq true
    end
  end
end
