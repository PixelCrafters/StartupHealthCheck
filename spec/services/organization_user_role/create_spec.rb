require 'spec_helper'

describe OrganizationUserRole::Create do
  describe "#call" do
    current_user = FactoryGirl.build(:user)
    role = Role.create(name: "Founder")
    organization = FactoryGirl.build(:organization)

    it "should create the organization_user_role" do
      organization_user_role = OrganizationUserRole::Create.call(role.id, organization, current_user)
      expect(organization_user_role.persisted?).to eq true
    end
  end
end
